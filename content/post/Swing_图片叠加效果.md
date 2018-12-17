---
title: '[Swing]图片叠加效果'
date: 2014-12-25 08:20:49
categories: 
- Java
tags: 
- java
- swing
- overlay
- image
- 图片叠加效果
---
玩一下使用Java做图片叠加效果。
![Swing：图片叠加效果](/images/2014/12/0026uWfMgy6OF3zPepRf3.png)
代码如下：
```
package com.yqu.swing.img;

import java.awt.Component;
import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;
import javax.swing.GrayFilter;
import javax.swing.Icon;
import javax.swing.ImageIcon;

public class OverlayIcon implements Icon{
  private int maxWidth = -1, maxHeight = -1;
  private List icons;
  
  public OverlayIcon(String[] iconPaths) {
    if(iconPaths != null && iconPaths.length >0) {
      icons = new ArrayList(iconPaths.length);
      for (String iconPath : iconPaths) {
        Icon icon = makeIcon(iconPath, false);
        icons.add(icon);
        int width = icon.getIconWidth();
        int height = icon.getIconHeight();
        if (width > maxWidth)
          maxWidth = width;
        if (height > maxHeight)
          maxHeight = height;
      }
      if (maxWidth == -1)
        maxWidth = 16;
      if (maxHeight == -1)
        maxHeight = 16;
    }
  }
  
  private Icon makeIcon(String iconPath, boolean makeDisabled) {
    ImageIcon icon = new ImageIcon(iconPath);
    if (makeDisabled) {
      icon = new ImageIcon(
          GrayFilter.createDisabledImage(icon.getImage()));
    }
    return icon;
  }
  
  private BufferedImage getBufferedImage() {
    BufferedImage bi = new BufferedImage(maxWidth, maxHeight,
        BufferedImage.TYPE_INT_ARGB);
    for (Icon icon : icons) {
      icon.paintIcon(null, bi.getGraphics(), 0, 0);
    }
    return bi;
  }
    
  public Icon getIcon() {
    if(icons != null) {
      BufferedImage bi = getBufferedImage();
      return new ImageIcon(bi);
    }
    return null;
  }
  
  public void saveIcon(String flName) {
    if(icons != null) {
      BufferedImage bi = getBufferedImage();
      try {
        ImageIO.write(bi, "gif", new File(flName));
      } catch (IOException e) {
        e.printStackTrace();
      }
    } else {
      throw new IllegalStateException("Can't generate overlay icon file");
    }
  }
  
  @Override
  public void paintIcon(Component c, Graphics g, int x, int y) {
    if(icons != null) {
      for (Icon icon : icons) {
         icon.paintIcon(c, g, x, y);
      }
    }
  }

  @Override
  public int getIconWidth() {
    return maxWidth;
  }

  @Override
  public int getIconHeight() {
    return maxHeight;
  }
  
  public static void main(String[] args) {
    String[] iconPaths = {"Cycle.gif", "New_overlay.gif"};
    OverlayIcon icon = new OverlayIcon(iconPaths);
    icon.saveIcon("New_Cycle.gif");    
  }
}
```
