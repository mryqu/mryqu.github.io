---
title: React-Redux Action链式调用  
date: 2020-05-10 06:01:23
categories: 
- FrontEnd
tags:
- React
- Redux
- Action
- Chain
---

在进行[React-Redux](https://redux.js.org/)实践时，碰到下面这样一个场景，执行一个UI操作需要链式次序分发多个Action。  
例如，删除一个post时，需要通过axios删除选中的post，然后通过axios获取所有post以刷新post列表，最后将选中的post id设为空。  前两个action为异步action，后一个action为同步action。  
下面就对我的实践进行一下总结。  

### 实现  

PostActions.js:  
```
......

export const handleSelectIdChange = selectedId => ({
  type: types.UPDATE_SELECTED_ID,
  payload: {
    data: selectedId
  }
});


......

export const getPosts = () => {
  return dispatch => {
    dispatch(getPostsStarted());

    return axios
      .get('/api/posts')
      .then(res => {
        dispatch(getPostsSuccess(res.data));
      })
      .catch(err => {
        dispatch(getPostsFailure(err.message));
      });
  };
}

export const getPostsSuccess = posts => ({
  type: types.GET_POSTS_SUCCESS,
  payload: {
    data: posts
  }
});

export const getPostsStarted = () => ({
  type: types.GET_POSTS_STARTED
});

export const getPostsFailure = error => ({
  type: types.GET_POSTS_FAILURE,
  payload: {
    error: error
  }
});

export const getPost = (id) => {
  return dispatch => {
    dispatch(getPostStarted());

    return axios
      .get('/api/posts/'+id)
      .then(res => {
        dispatch(getPostSuccess(res.data));
      })
      .catch(err => {
        dispatch(getPostFailure(err.message));
      });
  };
};

export const getPostSuccess = post => {
  return {
    type: types.GET_POST_SUCCESS,
    payload: {
      data: post
    }
  }
};

export const getPostStarted = () => ({
  type: types.GET_POST_STARTED
});

export const getPostFailure = error => ({
  type: types.GET_POST_FAILURE,
  payload: {
    error: error
  }
});

export const createPost = (post) => {
  return dispatch => {
    dispatch(createPostStarted());

    return axios
      .post('/api/posts/', post)
      .then(res => {
        dispatch(createPostSuccess(res.data));
      })
      .catch(err => {
        dispatch(createPostFailure(err.message));
      });
  };
};

export const createPostSuccess = post => ({
  type: types.CREATE_POST_SUCCESS,
  payload: {
    data: post
  }
});

export const createPostStarted = () => ({
  type: types.CREATE_POST_STARTED
});

export const createPostFailure = error => ({
  type: types.CREATE_POST_FAILURE,
  payload: {
    error: error
  }
});

export const updatePost = (post) => {
  return dispatch => {
    dispatch(updatePostStarted());

    return axios
      .put('/api/posts/'+post.id, post)
      .then(res => {
        dispatch(updatePostSuccess(res.data));
      })
      .catch(err => {
        dispatch(updatePostFailure(err.message));
      });
  };
};

export const updatePostSuccess = post => ({
  type: types.UPDATE_POST_SUCCESS,
  payload: {
    data: post
  }
});

export const updatePostStarted = () => ({
  type: types.UPDATE_POST_STARTED
});

export const updatePostFailure = error => ({
  type: types.UPDATE_POST_FAILURE,
  payload: {
    error: error
  }
});

export const deletePost = (id) => {
  return dispatch => {
    dispatch(deletePostStarted());

    return axios
      .delete('/api/posts/'+id)
      .then(res => {
        dispatch(deletePostSuccess(res.data));
      })
      .catch(err => {
        dispatch(deletePostFailure(err.message));
      });
  };
};

export const deletePostSuccess = post => ({
  type: types.DELETE_POST_SUCCESS,
  payload: {
    data: post
  }
});

export const deletePostStarted = () => ({
  type: types.DELETE_POST_STARTED
});

export const deletePostFailure = error => ({
  type: types.DELETE_POST_FAILURE,
  payload: {
    error: error
  }
});
```

PostToolbar.js:  
```
const mapDispatchToProps = (dispatch) => {
  return {
    ......
    handleDelete: (selectedId) => {
      dispatch(deletePost(selectedId))
        .then(() => dispatch(getPosts()))
        .then(() => dispatch(handleSelectIdChange(null)))
    }
  }
};
```

### 探讨  

#### 同时分发多个Action  

一个操作需要同时分发多个Action的话，多次调用dispatch即可。这些Action如果为异步的话，不保证Action返回结果的次序。  
```
handleOperation: () => {
  dispatch(action1);
  dispatch(action2);
  dispatch(action3);
}
```

#### 链式次序分发多个Action    

如果需要action1执行完，再执行action2，......，最后再执行actionN。 
通过查看[React-Redux](https://redux.js.org/)的dispatch方法，可知它最后返回的是输入值action。  
```
function dispatch(action) {
  if (!isPlainObject(action)) {
    throw new Error('Actions must be plain objects. ' + 'Use custom middleware for async actions.');
  }

  if (typeof action.type === 'undefined') {
    throw new Error('Actions may not have an undefined "type" property. ' + 'Have you misspelled a constant?');
  }

  if (isDispatching) {
    throw new Error('Reducers may not dispatch actions.');
  }

  try {
    isDispatching = true;
    currentState = currentReducer(currentState, action);
  } finally {
    isDispatching = false;
  }

  var listeners = currentListeners = nextListeners;

  for (var i = 0; i < listeners.length; i++) {
    var listener = listeners[i];
    listener();
  }

  return action;
}
``` 
如果每个Action都返回的是Promise对象，那就可以通过Promise对象的then特性可以实现链式次序分发多个Action。
我上面的实现即通过这种方式实现的。示例中的handleSelectIdChange Action后面如果还需要执行其他Action，就需要改写handleSelectIdChange Action使其返回Promise对象。  
```
export const handleSelectIdChange = selectedId => {
  return dispatch => {
    return new Promise( (resolve) => {
      dispatch({
        type: types.UPDATE_SELECTED_ID,
        payload: {
          data: selectedId
        }
      })
      resolve();
    })
  }
};
```
或者  
```
export const handleSelectIdChange = selectedId => {
  return dispatch => {
    dispatch({
      type: types.UPDATE_SELECTED_ID,
      payload: {
        data: selectedId
      }
    });
    return Promise.resolve();    
  }
};
```

#### 其他需求  

上面的实现中，deletePost Action中axios.delete方法成功和失败后分发的Action是固定的，然后通过then方法分发的后继Action是不固定的。但如果想让deletePost Action中axios.delete成功/失败要分发的Action不是固定的呢？更进一步的，如果想通过PostActions.js中Action组合包含同时分发多个Action和链式次序分发多个Action的Action流呢？  
那要求Action返回的不仅仅是Promise对象，还含有resolve和reject结果，以便后继用于判断Action流的分支走向。  

### 参考

* [How to chain async actions?](https://github.com/reduxjs/redux/issues/1676)  
* [How do I chain actions with Redux Promise Middleware?](https://stackoverflow.com/questions/51987573/how-do-i-chain-actions-with-redux-promise-middleware)  

