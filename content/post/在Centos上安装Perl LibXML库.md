---
title: '在Centos上安装Perl LibXML库记录'
date: 2021-01-04 12:31:23
categories: 
- Tool
- Linux
tags: 
- XML::LibXML
- install
- Centos

---

一开始使用cpan安装，揍是不成功。  
```
[root@mryqulax ~]# perldoc -m XML::LibXML
No module found for "XML::LibXML".
[root@mryqulax ~]# perl -MCPAN -e shell
Terminal does not support AddHistory.

cpan shell -- CPAN exploration and modules installation (v1.9800)
Enter 'h' for help.

cpan[1]> install XML::LibXML
CPAN: Storable loaded ok (v2.20)
Reading '/root/.cpan/Metadata'
  Database was generated on Sun, 24 Nov 2013 10:53:02 GMT
CPAN: LWP::UserAgent loaded ok (v6.04)
CPAN: Time::HiRes loaded ok (v1.9721)
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/01mailrc.txt.gz
Reading '/root/.cpan/sources/authors/01mailrc.txt.gz'
CPAN: Compress::Zlib loaded ok (v2.049)
............................................................................DONE
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/modules/02packages.details.txt.gz
Reading '/root/.cpan/sources/modules/02packages.details.txt.gz'
  Database was generated on Tue, 29 Dec 2020 11:56:01 GMT
.............
  New CPAN.pm version (v2.28) available.
  [Currently running version is v1.9800]
  You might want to try
    install CPAN
    reload cpan
  to both upgrade CPAN.pm and run the new version without leaving
  the current session.


...............................................................DONE
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/modules/03modlist.data.gz
Reading '/root/.cpan/sources/modules/03modlist.data.gz'
DONE
Writing /root/.cpan/Metadata
Running install for module 'XML::LibXML'
Running make for S/SH/SHLOMIF/XML-LibXML-2.0206.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/S/SH/SHLOMIF/XML-LibXML-2.0206.tar.gz
CPAN: Digest::SHA loaded ok (v5.47)
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/S/SH/SHLOMIF/CHECKSUMS
Checksum for /root/.cpan/sources/authors/id/S/SH/SHLOMIF/XML-LibXML-2.0206.tar.gz ok
Scanning cache /root/.cpan/build for sizes
............................................................................DONE
CPAN: Archive::Tar loaded ok (v1.58)
XML-LibXML-2.0206/
XML-LibXML-2.0206/perl-libxml-mm.h
XML-LibXML-2.0206/TODO
XML-LibXML-2.0206/Changes
XML-LibXML-2.0206/lib/
XML-LibXML-2.0206/lib/XML/
XML-LibXML-2.0206/lib/XML/LibXML/
XML-LibXML-2.0206/lib/XML/LibXML/CDATASection.pod
XML-LibXML-2.0206/lib/XML/LibXML/Document.pod
XML-LibXML-2.0206/lib/XML/LibXML/PI.pod
XML-LibXML-2.0206/lib/XML/LibXML/Common.pod
XML-LibXML-2.0206/lib/XML/LibXML/InputCallback.pod
XML-LibXML-2.0206/lib/XML/LibXML/Literal.pm
XML-LibXML-2.0206/lib/XML/LibXML/XPathExpression.pod
XML-LibXML-2.0206/lib/XML/LibXML/SAX.pm
XML-LibXML-2.0206/lib/XML/LibXML/NodeList.pm
XML-LibXML-2.0206/lib/XML/LibXML/Schema.pod
XML-LibXML-2.0206/lib/XML/LibXML/Error.pm
XML-LibXML-2.0206/lib/XML/LibXML/Text.pod
XML-LibXML-2.0206/lib/XML/LibXML/ErrNo.pod
XML-LibXML-2.0206/lib/XML/LibXML/Pattern.pod
XML-LibXML-2.0206/lib/XML/LibXML/Dtd.pod
XML-LibXML-2.0206/lib/XML/LibXML/DocumentFragment.pod
XML-LibXML-2.0206/lib/XML/LibXML/RelaxNG.pod
XML-LibXML-2.0206/lib/XML/LibXML/XPathContext.pod
XML-LibXML-2.0206/lib/XML/LibXML/Boolean.pm
XML-LibXML-2.0206/lib/XML/LibXML/Devel.pm
XML-LibXML-2.0206/lib/XML/LibXML/Number.pm
XML-LibXML-2.0206/lib/XML/LibXML/Reader.pod
XML-LibXML-2.0206/lib/XML/LibXML/Error.pod
XML-LibXML-2.0206/lib/XML/LibXML/XPathContext.pm
XML-LibXML-2.0206/lib/XML/LibXML/SAX.pod
XML-LibXML-2.0206/lib/XML/LibXML/Reader.pm
XML-LibXML-2.0206/lib/XML/LibXML/Common.pm
XML-LibXML-2.0206/lib/XML/LibXML/Node.pod
XML-LibXML-2.0206/lib/XML/LibXML/Element.pod
XML-LibXML-2.0206/lib/XML/LibXML/SAX/
XML-LibXML-2.0206/lib/XML/LibXML/SAX/Generator.pm
XML-LibXML-2.0206/lib/XML/LibXML/SAX/Parser.pm
XML-LibXML-2.0206/lib/XML/LibXML/SAX/Builder.pm
XML-LibXML-2.0206/lib/XML/LibXML/SAX/Builder.pod
XML-LibXML-2.0206/lib/XML/LibXML/AttributeHash.pm
XML-LibXML-2.0206/lib/XML/LibXML/RegExp.pod
XML-LibXML-2.0206/lib/XML/LibXML/Parser.pod
XML-LibXML-2.0206/lib/XML/LibXML/ErrNo.pm
XML-LibXML-2.0206/lib/XML/LibXML/Attr.pod
XML-LibXML-2.0206/lib/XML/LibXML/Namespace.pod
XML-LibXML-2.0206/lib/XML/LibXML/Comment.pod
XML-LibXML-2.0206/lib/XML/LibXML/DOM.pod
XML-LibXML-2.0206/LICENSE
XML-LibXML-2.0206/MANIFEST
XML-LibXML-2.0206/xpath.h
XML-LibXML-2.0206/example/
XML-LibXML-2.0206/example/test3.xml
XML-LibXML-2.0206/example/JBR-ALLENtrees.htm
XML-LibXML-2.0206/example/article_internal.xml
XML-LibXML-2.0206/example/create-sample-html-document.pl
XML-LibXML-2.0206/example/dtd.xml
XML-LibXML-2.0206/example/xmlns/
XML-LibXML-2.0206/example/xmlns/goodguy.xml
XML-LibXML-2.0206/example/xmlns/badguy.xml
XML-LibXML-2.0206/example/cb_example.pl
XML-LibXML-2.0206/example/utf-16-1.html
XML-LibXML-2.0206/example/test.dtd
XML-LibXML-2.0206/example/test4.xml
XML-LibXML-2.0206/example/ext_ent.dtd
XML-LibXML-2.0206/example/article_external_bad.xml
XML-LibXML-2.0206/example/enc_latin2.html
XML-LibXML-2.0206/example/xpath.pl
XML-LibXML-2.0206/example/test.html
XML-LibXML-2.0206/example/article.xml
XML-LibXML-2.0206/example/article_internal_bad.xml
XML-LibXML-2.0206/example/catalog.xml
XML-LibXML-2.0206/example/bad.xml
XML-LibXML-2.0206/example/utf-16-2.xml
XML-LibXML-2.0206/example/test.xml
XML-LibXML-2.0206/example/test2.xml
XML-LibXML-2.0206/example/dromeds.xml
XML-LibXML-2.0206/example/enc2_latin2.html
XML-LibXML-2.0206/example/yahoo-finance-html-with-errors.html
XML-LibXML-2.0206/example/article_bad.xml
XML-LibXML-2.0206/example/complex/
XML-LibXML-2.0206/example/complex/complex.dtd
XML-LibXML-2.0206/example/complex/dtd/
XML-LibXML-2.0206/example/complex/dtd/g.dtd
XML-LibXML-2.0206/example/complex/dtd/f.dtd
XML-LibXML-2.0206/example/complex/complex.xml
XML-LibXML-2.0206/example/complex/complex2.xml
XML-LibXML-2.0206/example/thedieline.rss
XML-LibXML-2.0206/example/test.xhtml
XML-LibXML-2.0206/example/xmllibxmldocs.pl
XML-LibXML-2.0206/example/ns.xml
XML-LibXML-2.0206/example/bad.dtd
XML-LibXML-2.0206/example/utf-16-2.html
XML-LibXML-2.0206/LibXML.pm
XML-LibXML-2.0206/Av_CharPtrPtr.h
XML-LibXML-2.0206/LibXML.pod
XML-LibXML-2.0206/Makefile.PL
XML-LibXML-2.0206/docs/
XML-LibXML-2.0206/docs/libxml.dbk
XML-LibXML-2.0206/META.yml
XML-LibXML-2.0206/Av_CharPtrPtr.c
XML-LibXML-2.0206/test/
XML-LibXML-2.0206/test/schema/
XML-LibXML-2.0206/test/schema/demo.xml
XML-LibXML-2.0206/test/schema/net.xsd
XML-LibXML-2.0206/test/schema/badschema.xsd
XML-LibXML-2.0206/test/schema/invaliddemo.xml
XML-LibXML-2.0206/test/schema/schema.xsd
XML-LibXML-2.0206/test/xinclude/
XML-LibXML-2.0206/test/xinclude/entity.txt
XML-LibXML-2.0206/test/xinclude/xinclude.xml
XML-LibXML-2.0206/test/xinclude/test.xml
XML-LibXML-2.0206/test/textReader/
XML-LibXML-2.0206/test/textReader/countries.xml
XML-LibXML-2.0206/test/relaxng/
XML-LibXML-2.0206/test/relaxng/demo4.rng
XML-LibXML-2.0206/test/relaxng/demo.xml
XML-LibXML-2.0206/test/relaxng/demo3.rng
XML-LibXML-2.0206/test/relaxng/net.rng
XML-LibXML-2.0206/test/relaxng/badschema.rng
XML-LibXML-2.0206/test/relaxng/invaliddemo.xml
XML-LibXML-2.0206/test/relaxng/schema.rng
XML-LibXML-2.0206/test/relaxng/demo2.rng
XML-LibXML-2.0206/test/relaxng/demo.rng
XML-LibXML-2.0206/META.json
XML-LibXML-2.0206/perl-libxml-sax.h
XML-LibXML-2.0206/Devel.xs
XML-LibXML-2.0206/README
XML-LibXML-2.0206/t/
XML-LibXML-2.0206/t/48_memleak_rt_83744.t
XML-LibXML-2.0206/t/00-report-prereqs.t
XML-LibXML-2.0206/t/90stack.t
XML-LibXML-2.0206/t/60struct_error.t
XML-LibXML-2.0206/t/90threads.t
XML-LibXML-2.0206/t/48_reader_undef_warning_on_empty_str_rt106830.t
XML-LibXML-2.0206/t/25relaxng.t
XML-LibXML-2.0206/t/90shared_clone_failed_rt_91800.t
XML-LibXML-2.0206/t/72destruction.t
XML-LibXML-2.0206/t/48_RH5_double_free_rt83779.t
XML-LibXML-2.0206/t/29id.t
XML-LibXML-2.0206/t/09xpath.t
XML-LibXML-2.0206/t/lib/
XML-LibXML-2.0206/t/lib/Stacker.pm
XML-LibXML-2.0206/t/lib/Counter.pm
XML-LibXML-2.0206/t/lib/Collector.pm
XML-LibXML-2.0206/t/lib/TestHelpers.pm
XML-LibXML-2.0206/t/19encoding.t
XML-LibXML-2.0206/t/style-trailing-space.t
XML-LibXML-2.0206/t/41xinclude.t
XML-LibXML-2.0206/t/46err_column.t
XML-LibXML-2.0206/t/49callbacks_returning_undef.t
XML-LibXML-2.0206/t/80registryleak.t
XML-LibXML-2.0206/t/23rawfunctions.t
XML-LibXML-2.0206/t/06elements.t
XML-LibXML-2.0206/t/61error.t
XML-LibXML-2.0206/t/27new_callbacks_simple.t
XML-LibXML-2.0206/t/42common.t
XML-LibXML-2.0206/t/62overload.t
XML-LibXML-2.0206/t/48_replaceNode_DTD_nodes_rT_80521.t
XML-LibXML-2.0206/t/28new_callbacks_multiple.t
XML-LibXML-2.0206/t/03doc.t
XML-LibXML-2.0206/t/60error_prev_chain.t
XML-LibXML-2.0206/t/40reader.t
XML-LibXML-2.0206/t/31xpc_functions.t
XML-LibXML-2.0206/t/48_removeChild_crashes_rt_80395.t
XML-LibXML-2.0206/t/43options.t
XML-LibXML-2.0206/t/48_rt55000.t
XML-LibXML-2.0206/t/cpan-changes.t
XML-LibXML-2.0206/t/05text.t
XML-LibXML-2.0206/t/10ns.t
XML-LibXML-2.0206/t/12html.t
XML-LibXML-2.0206/t/48_SAX_Builder_rt_91433.t
XML-LibXML-2.0206/t/48_rt93429_recover_2_in_html_parsing.t
XML-LibXML-2.0206/t/17callbacks.t
XML-LibXML-2.0206/t/48importing_nodes_IDs_rt_69520.t
XML-LibXML-2.0206/t/21catalog.t
XML-LibXML-2.0206/t/30keep_blanks.t
XML-LibXML-2.0206/t/20extras.t
XML-LibXML-2.0206/t/26schema.t
XML-LibXML-2.0206/t/pod.t
XML-LibXML-2.0206/t/47load_xml_callbacks.t
XML-LibXML-2.0206/t/13dtd.t
XML-LibXML-2.0206/t/35huge_mode.t
XML-LibXML-2.0206/t/71overloads.t
XML-LibXML-2.0206/t/data/
XML-LibXML-2.0206/t/data/callbacks_returning_undef.xml
XML-LibXML-2.0206/t/data/chinese.xml
XML-LibXML-2.0206/t/07dtd.t
XML-LibXML-2.0206/t/49global_extent.t
XML-LibXML-2.0206/t/40reader_mem_error.t
XML-LibXML-2.0206/t/04node.t
XML-LibXML-2.0206/t/24c14n.t
XML-LibXML-2.0206/t/14sax.t
XML-LibXML-2.0206/t/44extent.t
XML-LibXML-2.0206/t/45regex.t
XML-LibXML-2.0206/t/11memory.t
XML-LibXML-2.0206/t/01basic.t
XML-LibXML-2.0206/t/50devel.t
XML-LibXML-2.0206/t/18docfree.t
XML-LibXML-2.0206/t/08findnodes.t
XML-LibXML-2.0206/t/48_rt123379_setNamespace.t
XML-LibXML-2.0206/t/19die_on_invalid_utf8_rt_58848.t
XML-LibXML-2.0206/t/49_load_html.t
XML-LibXML-2.0206/t/release-kwalitee.t
XML-LibXML-2.0206/t/02parse.t
XML-LibXML-2.0206/t/15nodelist.t
XML-LibXML-2.0206/t/16docnodes.t
XML-LibXML-2.0206/t/51_parse_html_string_rt87089.t
XML-LibXML-2.0206/t/91unique_key.t
XML-LibXML-2.0206/t/pod-files-presence.t
XML-LibXML-2.0206/t/30xpathcontext.t
XML-LibXML-2.0206/t/32xpc_variables.t
XML-LibXML-2.0206/perl-libxml-sax.c
XML-LibXML-2.0206/debian/
XML-LibXML-2.0206/debian/changelog
XML-LibXML-2.0206/debian/libxml-libxml-perl.install
XML-LibXML-2.0206/debian/libxml-libxml-perl.postinst
XML-LibXML-2.0206/debian/libxml-libxml-perl.examples
XML-LibXML-2.0206/debian/libxml-libxml-perl.prerm
XML-LibXML-2.0206/debian/copyright
XML-LibXML-2.0206/debian/compat
XML-LibXML-2.0206/debian/libxml-libxml-perl.docs
XML-LibXML-2.0206/debian/control
XML-LibXML-2.0206/debian/rules
XML-LibXML-2.0206/typemap
XML-LibXML-2.0206/scripts/
XML-LibXML-2.0206/scripts/bump-version-number.pl
XML-LibXML-2.0206/scripts/tag-release.pl
XML-LibXML-2.0206/scripts/fast-eumm.pl
XML-LibXML-2.0206/scripts/total-build-and-test.bash
XML-LibXML-2.0206/scripts/update-HACKING-file.bash
XML-LibXML-2.0206/scripts/prints-to-comments.pl
XML-LibXML-2.0206/scripts/Test.pm-to-Test-More.pl
XML-LibXML-2.0206/LibXML.xs
XML-LibXML-2.0206/ppport.h
XML-LibXML-2.0206/xpath.c
XML-LibXML-2.0206/dom.c
XML-LibXML-2.0206/HACKING.txt
XML-LibXML-2.0206/perl-libxml-mm.c
XML-LibXML-2.0206/xpathcontext.h
XML-LibXML-2.0206/dom.h
CPAN: File::Temp loaded ok (v0.22)
CPAN: Parse::CPAN::Meta loaded ok (v1.4404)
CPAN: CPAN::Meta loaded ok (v2.120921)
CPAN: Module::CoreList loaded ok (v2.18)
---- Unsatisfied dependencies detected during ----
----     SHLOMIF/XML-LibXML-2.0206.tar.gz     ----
    Alien::Base::Wrapper [build_requires]
    Alien::Libxml2 [build_requires]
Running make test
  Make had some problems, won't test
  Delayed until after prerequisites
Running make install
  Make had some problems, won't install
  Delayed until after prerequisites
Running install for module 'Alien::Base::Wrapper'
Running make for P/PL/PLICEASE/Alien-Build-2.37.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/P/PL/PLICEASE/Alien-Build-2.37.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/P/PL/PLICEASE/CHECKSUMS
Checksum for /root/.cpan/sources/authors/id/P/PL/PLICEASE/Alien-Build-2.37.tar.gz ok
Alien-Build-2.37
Alien-Build-2.37/README
Alien-Build-2.37/SUPPORT
Alien-Build-2.37/Changes
Alien-Build-2.37/LICENSE
Alien-Build-2.37/INSTALL
Alien-Build-2.37/dist.ini
Alien-Build-2.37/META.yml
Alien-Build-2.37/MANIFEST
Alien-Build-2.37/META.json
Alien-Build-2.37/author.yml
Alien-Build-2.37/t
Alien-Build-2.37/t/01_use.t
Alien-Build-2.37/t/bin
Alien-Build-2.37/t/bin/ftpd
Alien-Build-2.37/t/00_diag.t
Alien-Build-2.37/t/bin/httpd
Alien-Build-2.37/Makefile.PL
Alien-Build-2.37/perlcriticrc
Alien-Build-2.37/maint
Alien-Build-2.37/maint/gen.pl
Alien-Build-2.37/t/alienfile.t
Alien-Build-2.37/t/alien_base.t
Alien-Build-2.37/t/test_alien.t
Alien-Build-2.37/t/alien_role.t
Alien-Build-2.37/example
Alien-Build-2.37/example/README
Alien-Build-2.37/inc
Alien-Build-2.37/inc/trivial.xs
Alien-Build-2.37/t/alien_build.t
Alien-Build-2.37/inc/probebad.pl
Alien-Build-2.37/xt/author
Alien-Build-2.37/xt/author/eol.t
Alien-Build-2.37/xt/author/pod.t
Alien-Build-2.37/lib
Alien-Build-2.37/lib/alienfile.pm
Alien-Build-2.37/lib/Test
Alien-Build-2.37/lib/Test/Alien.pm
Alien-Build-2.37/lib/Alien
Alien-Build-2.37/lib/Alien/Base.pm
Alien-Build-2.37/lib/Alien/Role.pm
Alien-Build-2.37/maint/travis-dzil
Alien-Build-2.37/Changes.Test-Alien
Alien-Build-2.37/Changes.Alien-Base
Alien-Build-2.37/lib/Alien/Build.pm
Alien-Build-2.37/t/alien_build_rc.t
Alien-Build-2.37/t/alien_build_mm.t
Alien-Build-2.37/t/test_alien_run.t
Alien-Build-2.37/xt/author/critic.t
Alien-Build-2.37/example/wrapper.pl
Alien-Build-2.37/corpus/rc
Alien-Build-2.37/corpus/rc/basic.pl
Alien-Build-2.37/xt/author/strict.t
Alien-Build-2.37/xt/release
Alien-Build-2.37/xt/release/fixme.t
Alien-Build-2.37/t/alien_build_log.t
Alien-Build-2.37/t/test_alien_diag.t
Alien-Build-2.37/t/lib/MyTest
Alien-Build-2.37/t/lib/MyTest/FTP.pm
Alien-Build-2.37/maint/travis-daemon
Alien-Build-2.37/example/user
Alien-Build-2.37/example/user/README
Alien-Build-2.37/corpus/dir
Alien-Build-2.37/corpus/dir/ftp.list
Alien-Build-2.37/xt/author/no_tabs.t
Alien-Build-2.37/xt/author/version.t
Alien-Build-2.37/t/alien_build_temp.t
Alien-Build-2.37/t/alien_build_util.t
Alien-Build-2.37/t/test_alien_build.t
Alien-Build-2.37/t/alien_build_meta.t
Alien-Build-2.37/t/lib/MyTest/HTTP.pm
Alien-Build-2.37/t/lib/MyTest/File.pm
Alien-Build-2.37/xt/author/filename.t
Alien-Build-2.37/example/xz.alienfile
Alien-Build-2.37/corpus/dist2
Alien-Build-2.37/corpus/dist2/foo.tar
Alien-Build-2.37/corpus/dir/file.html
Alien-Build-2.37/corpus/dir/http.html
Alien-Build-2.37/xt/release/changes.t
Alien-Build-2.37/lib/Test/Alien
Alien-Build-2.37/lib/Test/Alien/Run.pm
Alien-Build-2.37/lib/Alien/Build
Alien-Build-2.37/lib/Alien/Build/MM.pm
Alien-Build-2.37/lib/Alien/Build/rc.pm
Alien-Build-2.37/maint/travis-run-test
Alien-Build-2.37/lib/Test/Alien/Diag.pm
Alien-Build-2.37/lib/Alien/Build/Log.pm
Alien-Build-2.37/lib/Alien/Base
Alien-Build-2.37/lib/Alien/Base/FAQ.pod
Alien-Build-2.37/t/alien_build_plugin.t
Alien-Build-2.37/t/alien_base_wrapper.t
Alien-Build-2.37/t/lib/MyTest/System.pm
Alien-Build-2.37/maint/cip-test-plugins
Alien-Build-2.37/example/curl.alienfile
Alien-Build-2.37/corpus/basic
Alien-Build-2.37/corpus/basic/alienfile
Alien-Build-2.37/corpus/blank
Alien-Build-2.37/corpus/blank/alienfile
Alien-Build-2.37/lib/Test/Alien/Build.pm
Alien-Build-2.37/lib/Alien/Build/Util.pm
Alien-Build-2.37/lib/Alien/Build/Temp.pm
Alien-Build-2.37/t/alien_build_tempdir.t
Alien-Build-2.37/example/gmake.alienfile
Alien-Build-2.37/example/bzip2.alienfile
Alien-Build-2.37/corpus/lib/Alien
Alien-Build-2.37/corpus/lib/Alien/Foo.pm
Alien-Build-2.37/corpus/dir/ftp_abs.list
Alien-Build-2.37/t/test_alien_synthetic.t
Alien-Build-2.37/t/alien_base_pkgconfig.t
Alien-Build-2.37/maint/ci-test-plugins.pl
Alien-Build-2.37/maint/cip-before-install
Alien-Build-2.37/corpus/lib/Alien/Foo1.pm
Alien-Build-2.37/corpus/lib/Alien/Foo2.pm
Alien-Build-2.37/corpus/dir/http_rel.html
Alien-Build-2.37/corpus/dist
Alien-Build-2.37/corpus/dist/foo-1.00.zip
Alien-Build-2.37/corpus/dist/foo-1.00.tar
Alien-Build-2.37/xt/author/pod_coverage.t
Alien-Build-2.37/lib/Alien/Build/Plugin.pm
Alien-Build-2.37/lib/Alien/Base/Wrapper.pm
Alien-Build-2.37/t/test_alien_cancompile.t
Alien-Build-2.37/maint/travis-install-deps
Alien-Build-2.37/example/openssl.alienfile
Alien-Build-2.37/corpus/lib/Foo/Bar
Alien-Build-2.37/corpus/lib/Foo/Bar/Baz.pm
Alien-Build-2.37/Changes.Alien-Base-Wrapper
Alien-Build-2.37/t/test_alien_canplatypus.t
Alien-Build-2.37/maint/gen-test-archives.pl
Alien-Build-2.37/corpus/lib/Foo/Bar/Baz1.pm
Alien-Build-2.37/corpus/ab_pkgconfig
Alien-Build-2.37/corpus/ab_pkgconfig/gsl.pc
Alien-Build-2.37/corpus/dist/foo-1.00.tar.Z
Alien-Build-2.37/corpus/dist/foo-1.00
Alien-Build-2.37/corpus/dist/foo-1.00/foo.c
Alien-Build-2.37/lib/Test/Alien/Synthetic.pm
Alien-Build-2.37/lib/Alien/Base/PkgConfig.pm
Alien-Build-2.37/t/alien_build_log_default.t
Alien-Build-2.37/t/alien_build_plugin_meta.t
Alien-Build-2.37/t/alien_build_interpolate.t
Alien-Build-2.37/example/xz-manual.alienfile
Alien-Build-2.37/example/dontpanic.alienfile
Alien-Build-2.37/example/user/xs-mb
Alien-Build-2.37/example/user/xs-mb/Build.PL
Alien-Build-2.37/corpus/lib/pkgconfig
Alien-Build-2.37/corpus/lib/pkgconfig/xor.pc
Alien-Build-2.37/corpus/lib/pkgconfig/foo.pc
Alien-Build-2.37/corpus/lib/Alien/libfoo3.pm
Alien-Build-2.37/corpus/lib/Alien/libfoo2.pm
Alien-Build-2.37/corpus/lib/Alien/libfoo1.pm
Alien-Build-2.37/corpus/lib/Alien/foomake.pm
Alien-Build-2.37/corpus/ab_pkgconfig/test.pc
Alien-Build-2.37/corpus/pkgconfig
Alien-Build-2.37/corpus/pkgconfig/libbar1.pc
Alien-Build-2.37/corpus/pkgconfig/libfoo1.pc
Alien-Build-2.37/corpus/dist/foo-1.00.tar.gz
Alien-Build-2.37/corpus/dist/foo-1.00.tar.xz
Alien-Build-2.37/corpus/vcpkg/r1
Alien-Build-2.37/corpus/vcpkg/r1/.vcpkg-root
Alien-Build-2.37/corpus/vcpkg/r2
Alien-Build-2.37/corpus/vcpkg/r2/.vcpkg-root
Alien-Build-2.37/lib/Test/Alien/CanCompile.pm
Alien-Build-2.37/lib/Alien/Base/Authoring.pod
Alien-Build-2.37/corpus/dist/foo-1.00.tar.bz2
Alien-Build-2.37/lib/Test/Alien/CanPlatypus.pm
Alien-Build-2.37/t/alien_build_version_basic.t
Alien-Build-2.37/example/user/xs-dzil
Alien-Build-2.37/example/user/xs-dzil/dist.ini
Alien-Build-2.37/example/user/xs-mm
Alien-Build-2.37/example/user/xs-mm/Example.xs
Alien-Build-2.37/corpus/lib/Alien/SansShare.pm
Alien-Build-2.37/lib/Alien/Build/Interpolate.pm
Alien-Build-2.37/lib/Alien/Build/Manual
Alien-Build-2.37/lib/Alien/Build/Manual/FAQ.pod
Alien-Build-2.37/lib/Alien/Build/Log
Alien-Build-2.37/lib/Alien/Build/Log/Default.pm
Alien-Build-2.37/t/alien_build_log_abbreviate.t
Alien-Build-2.37/example/user/xs-mm/Makefile.PL
Alien-Build-2.37/corpus/dist/foo-1.00/configure
Alien-Build-2.37/Changes.Alien-Build-Decode-Mojo
Alien-Build-2.37/lib/Alien/Build/Plugin
Alien-Build-2.37/lib/Alien/Build/Plugin/Core.pod
Alien-Build-2.37/t/alien_build_plugin_core_ffi.t
Alien-Build-2.37/t/alien_build_commandsequence.t
Alien-Build-2.37/example/user/xs-dzil/Example.xs
Alien-Build-2.37/xt/author/pod_spelling_system.t
Alien-Build-2.37/lib/Alien/Build/Plugin/Probe.pod
Alien-Build-2.37/lib/Alien/Build/Plugin/Build.pod
Alien-Build-2.37/lib/Alien/Build/Plugin/Fetch.pod
Alien-Build-2.37/lib/Alien/Build/Version
Alien-Build-2.37/lib/Alien/Build/Version/Basic.pm
Alien-Build-2.37/lib/Alien/Build/Manual/Alien.pod
Alien-Build-2.37/t/alien_build_plugin_test_mock.t
Alien-Build-2.37/t/alien_base__system_installed.t
Alien-Build-2.37/t/alien_build_plugin_fetch_lwp.t
Alien-Build-2.37/t/alien_build_plugin_core_tail.t
Alien-Build-2.37/t/lib/MyTest/FauxFetchCommand.pm
Alien-Build-2.37/maint/update-cmake-libpalindrome
Alien-Build-2.37/lib/Alien/Build/Plugin/Decode.pod
Alien-Build-2.37/lib/Alien/Build/Plugin/Prefer.pod
Alien-Build-2.37/lib/Alien/Build/Log/Abbreviate.pm
Alien-Build-2.37/t/alien_build_plugin_build_msys.t
Alien-Build-2.37/t/alien_build_plugin_build_make.t
Alien-Build-2.37/t/alien_build_plugin_fetch_wget.t
Alien-Build-2.37/t/alien_build_plugin_core_setup.t
Alien-Build-2.37/t/alien_build_plugin_build_copy.t
Alien-Build-2.37/lib/Alien/Build/CommandSequence.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Extract.pod
Alien-Build-2.37/lib/Alien/Build/Plugin/Core
Alien-Build-2.37/lib/Alien/Build/Plugin/Core/FFI.pm
Alien-Build-2.37/t/alien_build_plugin_core_legacy.t
Alien-Build-2.37/t/alien_build_plugin_probe_vcpkg.t
Alien-Build-2.37/t/alien_build_plugin_fetch_local.t
Alien-Build-2.37/t/alien_build_plugin_build_cmake.t
Alien-Build-2.37/t/alien_build_plugin_decode_html.t
Alien-Build-2.37/t/alien_build_plugin_core_gather.t
Alien-Build-2.37/t/alien_build_plugin_decode_mojo.t
Alien-Build-2.37/example/user/tool/t
Alien-Build-2.37/example/user/tool/t/lzma_example.t
Alien-Build-2.37/corpus/cmake-libpalindrome
Alien-Build-2.37/corpus/cmake-libpalindrome/LICENSE
Alien-Build-2.37/lib/Alien/Build/Plugin/Download.pod
Alien-Build-2.37/lib/Alien/Build/Plugin/Fetch
Alien-Build-2.37/lib/Alien/Build/Plugin/Fetch/LWP.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Test
Alien-Build-2.37/lib/Alien/Build/Plugin/Test/Mock.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Core/Tail.pm
Alien-Build-2.37/t/alien_build_interpolate_default.t
Alien-Build-2.37/t/alien_build_plugin_pkgconfig_pp.t
Alien-Build-2.37/t/alien_build_commandsequence__cd.t
Alien-Build-2.37/t/alien_build_plugin_fetch_netftp.t
Alien-Build-2.37/example/user/xs-mm/t
Alien-Build-2.37/example/user/xs-mm/t/lzma_example.t
Alien-Build-2.37/example/user/xs-mb/t
Alien-Build-2.37/example/user/xs-mb/t/lzma_example.t
Alien-Build-2.37/corpus/lib/Alien/Foo1
Alien-Build-2.37/corpus/lib/Alien/Foo1/ConfigData.pm
Alien-Build-2.37/corpus/lib/Alien/Foo2
Alien-Build-2.37/corpus/lib/Alien/Foo2/ConfigData.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Build
Alien-Build-2.37/lib/Alien/Build/Plugin/Build/MSYS.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Build/Copy.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Build/Make.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Fetch/Wget.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Core/Setup.pm
Alien-Build-2.37/lib/Alien/Build/Manual/AlienUser.pod
Alien-Build-2.37/t/alien_build_plugin_core_download.t
Alien-Build-2.37/t/alien_build_plugin_core_override.t
Alien-Build-2.37/corpus/lib/pkgconfig/xor-chillout.pc
Alien-Build-2.37/lib/Alien/Build/Plugin/Build/CMake.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Fetch/Local.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Decode
Alien-Build-2.37/lib/Alien/Build/Plugin/Decode/Mojo.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Decode/HTML.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Core/Legacy.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Core/Gather.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Probe
Alien-Build-2.37/lib/Alien/Build/Plugin/Probe/Vcpkg.pm
Alien-Build-2.37/t/alien_build_plugin_fetch_localdir.t
Alien-Build-2.37/t/alien_build_plugin_build_autoconf.t
Alien-Build-2.37/t/alien_build_plugin_fetch_httptiny.t
Alien-Build-2.37/t/alien_build_plugin_probe_cbuilder.t
Alien-Build-2.37/example/user/xs-dzil/t
Alien-Build-2.37/example/user/xs-dzil/t/lzma_example.t
Alien-Build-2.37/example/user/tool/lib/LZMA
Alien-Build-2.37/example/user/tool/lib/LZMA/Example.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Fetch/NetFTP.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/PkgConfig
Alien-Build-2.37/lib/Alien/Build/Plugin/PkgConfig/PP.pm
Alien-Build-2.37/lib/Alien/Build/Manual/AlienAuthor.pod
Alien-Build-2.37/lib/Alien/Build/Interpolate
Alien-Build-2.37/lib/Alien/Build/Interpolate/Default.pm
Alien-Build-2.37/t/alien_build_plugin_build_searchdep.t
Alien-Build-2.37/maint/Alien-Base-PkgConfig
Alien-Build-2.37/maint/Alien-Base-PkgConfig/Makefile.PL
Alien-Build-2.37/example/user/inline-c/t
Alien-Build-2.37/example/user/inline-c/t/lzma_example.t
Alien-Build-2.37/example/user/xs-mm/lib/LZMA
Alien-Build-2.37/example/user/xs-mm/lib/LZMA/Example.pm
Alien-Build-2.37/example/user/xs-mb/lib/LZMA
Alien-Build-2.37/example/user/xs-mb/lib/LZMA/Example.xs
Alien-Build-2.37/example/user/xs-mb/lib/LZMA/Example.pm
Alien-Build-2.37/corpus/cmake-libpalindrome/palx
Alien-Build-2.37/corpus/cmake-libpalindrome/palx/main.c
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/status
Alien-Build-2.37/lib/Alien/Build/Plugin/Core/Download.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Core/Override.pm
Alien-Build-2.37/lib/Alien/Build/Manual/PluginAuthor.pod
Alien-Build-2.37/lib/Alien/Build/Manual/Contributing.pod
Alien-Build-2.37/lib/Alien/Build/Plugin/Build/Autoconf.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Fetch/LocalDir.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Fetch/HTTPTiny.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Probe/CBuilder.pm
Alien-Build-2.37/t/alien_build_plugin_probe_commandline.t
Alien-Build-2.37/t/alien_build_plugin_decode_dirlisting.t
Alien-Build-2.37/t/alien_build_plugin_fetch_curlcommand.t
Alien-Build-2.37/t/alien_build_plugin_extract_directory.t
Alien-Build-2.37/t/alien_build_plugin_extract_negotiate.t
Alien-Build-2.37/t/alien_build_plugin_core_cleaninstall.t
Alien-Build-2.37/t/alien_build_plugin_prefer_badversion.t
Alien-Build-2.37/example/user/xs-dzil/lib/LZMA
Alien-Build-2.37/example/user/xs-dzil/lib/LZMA/Example.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Build/SearchDep.pm
Alien-Build-2.37/t/alien_build_plugin_download_negotiate.t
Alien-Build-2.37/t/alien_build_plugin_extract_archivetar.t
Alien-Build-2.37/t/alien_build_plugin_prefer_goodversion.t
Alien-Build-2.37/t/alien_build_plugin_extract_archivezip.t
Alien-Build-2.37/example/user/inline-c/lib/LZMA
Alien-Build-2.37/example/user/inline-c/lib/LZMA/Example.pm
Alien-Build-2.37/corpus/cmake-libpalindrome/CMakeLists.txt
Alien-Build-2.37/t/alien_build_plugin_extract_commandline.t
Alien-Build-2.37/t/alien_build_plugin_pkgconfig_negotiate.t
Alien-Build-2.37/t/alien_build_plugin_prefer_sortversions.t
Alien-Build-2.37/example/user/ffi-platypus/t
Alien-Build-2.37/example/user/ffi-platypus/t/lzma_example.t
Alien-Build-2.37/corpus/lib/Alien/Build/Plugin/Fetch
Alien-Build-2.37/corpus/lib/Alien/Build/Plugin/Fetch/Foo.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Fetch/CurlCommand.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Decode/DirListing.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Prefer
Alien-Build-2.37/lib/Alien/Build/Plugin/Prefer/BadVersion.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Core/CleanInstall.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Probe/CommandLine.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Extract
Alien-Build-2.37/lib/Alien/Build/Plugin/Extract/Negotiate.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Extract/Directory.pm
Alien-Build-2.37/t/alien_build_plugin_probe_cbuilder__live.t
Alien-Build-2.37/t/alien_build_plugin_pkgconfig_libpkgconf.t
Alien-Build-2.37/t/alien_build_plugin_pkgconfig_makestatic.t
Alien-Build-2.37/lib/Alien/Build/Plugin/Prefer/GoodVersion.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Download
Alien-Build-2.37/lib/Alien/Build/Plugin/Download/Negotiate.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Extract/ArchiveTar.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Extract/ArchiveZip.pm
Alien-Build-2.37/t/alien_build_plugin_pkgconfig_commandline.t
Alien-Build-2.37/t/alien_build_plugin_gather_isolatedynamic.t
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-Foo2
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-Foo2/README
Alien-Build-2.37/corpus/lib/Alien/Build/Plugin
Alien-Build-2.37/corpus/lib/Alien/Build/Plugin/RogerRamjet.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Prefer/SortVersions.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/PkgConfig/Negotiate.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/Extract/CommandLine.pm
Alien-Build-2.37/example/user/ffi-platypus/lib/LZMA
Alien-Build-2.37/example/user/ffi-platypus/lib/LZMA/Example.pm
Alien-Build-2.37/corpus/lib/Alien/Build/Plugin/Fetch/Corpus.pm
Alien-Build-2.37/corpus/lib/Alien/Build/Plugin/Download
Alien-Build-2.37/corpus/lib/Alien/Build/Plugin/Download/Foo.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/PkgConfig/LibPkgConf.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/PkgConfig/MakeStatic.pm
Alien-Build-2.37/corpus/cmake-libpalindrome/palx/CMakeLists.txt
Alien-Build-2.37/lib/Alien/Build/Plugin/Gather
Alien-Build-2.37/lib/Alien/Build/Plugin/Gather/IsolateDynamic.pm
Alien-Build-2.37/lib/Alien/Build/Plugin/PkgConfig/CommandLine.pm
Alien-Build-2.37/t/alien_build_plugin_decode_dirlistingftpcopy.t
Alien-Build-2.37/t/alien_build_plugin_pkgconfig_negotiate__pick.t
Alien-Build-2.37/corpus/vcpkg/r1/installed/x64-windows/lib
Alien-Build-2.37/corpus/vcpkg/r1/installed/x64-windows/lib/foo.lib
Alien-Build-2.37/lib/Alien/Build/Plugin/Decode/DirListingFtpcopy.pm
Alien-Build-2.37/t/alien_build_plugin_extract_commandline__tar_can.t
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-Foo2/lib
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-Foo2/lib/libfoo2.a
Alien-Build-2.37/corpus/alien_build_plugin_fetch_wget/record
Alien-Build-2.37/corpus/alien_build_plugin_fetch_wget/record/old.yml
Alien-Build-2.37/corpus/vcpkg/r1/installed/x64-windows/include
Alien-Build-2.37/corpus/vcpkg/r1/installed/x64-windows/include/foo.h
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/include
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/include/ffi.h
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/include
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/include/ffi.h
Alien-Build-2.37/corpus/alien_build_plugin_fetch_wget/record/old.json
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/lib
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/lib/libffi.lib
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/bin
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/bin/libffi.dll
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/bin/libffi.pdb
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/lib
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/lib/libffi.lib
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/bin
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/bin/libffi.dll
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/bin/libffi.pdb
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/lib
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/lib/libfoo.a
Alien-Build-2.37/corpus/cmake-libpalindrome/libpalindrome
Alien-Build-2.37/corpus/cmake-libpalindrome/libpalindrome/palindrome.c
Alien-Build-2.37/corpus/alien_build_plugin_fetch_wget/dir
Alien-Build-2.37/corpus/alien_build_plugin_fetch_wget/dir/foo-1.01.tar
Alien-Build-2.37/corpus/alien_build_plugin_fetch_wget/dir/foo-1.02.tar
Alien-Build-2.37/corpus/alien_build_plugin_fetch_wget/dir/foo-1.00.tar
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/include
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/include/foo.h
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/bin
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/bin/foo-config
Alien-Build-2.37/corpus/lib/Alien/Build/Plugin/NesAdvantage
Alien-Build-2.37/corpus/lib/Alien/Build/Plugin/NesAdvantage/Negotiate.pm
Alien-Build-2.37/corpus/cmake-libpalindrome/libpalindrome/CMakeLists.txt
Alien-Build-2.37/corpus/alien_build_plugin_fetch_wget/dir/html_test.html
Alien-Build-2.37/corpus/vcpkg/r1/installed/x64-windows/debug/lib
Alien-Build-2.37/corpus/vcpkg/r1/installed/x64-windows/debug/lib/foo.lib
Alien-Build-2.37/corpus/lib/Alien/Build/Plugin/NesAdvantage/Controller.pm
Alien-Build-2.37/corpus/cmake-libpalindrome/libpalindrome/libpalindrome.h
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/include/ffitarget.h
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/include/ffitarget.h
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo1/_alien
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo1/_alien/alien.json
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo3/_alien
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo3/_alien/alien.json
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/_alien
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/_alien/alien.json
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/dynamic
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/dynamic/libfoo.so
Alien-Build-2.37/corpus/alien_build_plugin_fetch_curlcommand/record
Alien-Build-2.37/corpus/alien_build_plugin_fetch_curlcommand/record/old.yml
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/debug/lib
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/debug/lib/libffi.lib
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/debug/bin
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/debug/bin/libffi.dll
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/debug/bin/libffi.pdb
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/debug/lib
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/debug/lib/libffi.lib
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/debug/bin
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/debug/bin/libffi.dll
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/debug/bin/libffi.pdb
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo1/_alien/for_libfoo1
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/_alien/for_libfoo2
Alien-Build-2.37/corpus/alien_build_plugin_fetch_curlcommand/record/old.json
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/lib/pkgconfig
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/lib/pkgconfig/x1.pc
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/dynamic/libfoo.so.2
Alien-Build-2.37/corpus/alien_build_plugin_fetch_curlcommand/dir
Alien-Build-2.37/corpus/alien_build_plugin_fetch_curlcommand/dir/foo-1.01.tar
Alien-Build-2.37/corpus/alien_build_plugin_fetch_curlcommand/dir/foo-1.02.tar
Alien-Build-2.37/corpus/alien_build_plugin_fetch_curlcommand/dir/foo-1.00.tar
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/share/libffi
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/share/libffi/copyright
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/share/libffi
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/share/libffi/copyright
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/share/pkgconfig
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-libfoo2/share/pkgconfig/x2.pc
Alien-Build-2.37/corpus/alien_build_plugin_fetch_curlcommand/dir/html_test.html
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/lz4_1.9.2_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/lzo_2.10-4_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/libffi_3.3_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/libffi_3.3_x86-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/xxhash_0.7.0_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/bzip2_1.0.6-5_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/curl_7.68.0-1_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/zlib_1.2.11-6_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/openssl_1.1.1d_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/share/libffi/vcpkg_abi_info.txt
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/share/libffi/libffiConfig.cmake
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/share/libffi/vcpkg_abi_info.txt
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/share/libffi/libffiConfig.cmake
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/libxml2_2.9.9-5_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/libiconv_1.16-1_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/liblzma_5.2.4-4_x64-windows.list
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-Foo2/lib/libfoo2-3.2.1/include
Alien-Build-2.37/corpus/lib/auto/share/dist/Alien-Foo2/lib/libfoo2-3.2.1/include/foo2.h
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/share/libffi/libffiTargets.cmake
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/share/libffi/libffiTargets.cmake
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/libarchive_3.4.1_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/libressl_2.9.1-2_x64-windows.list
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/share/libffi/libffiConfigVersion.cmake
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/share/libffi/libffiTargets-debug.cmake
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/share/libffi/libffiConfigVersion.cmake
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/share/libffi/libffiTargets-debug.cmake
Alien-Build-2.37/corpus/vcpkg/r2/installed/x86-windows/share/libffi/libffiTargets-release.cmake
Alien-Build-2.37/corpus/vcpkg/r2/installed/x64-windows/share/libffi/libffiTargets-release.cmake
Alien-Build-2.37/corpus/vcpkg/r2/installed/vcpkg/info/openssl-windows_1.1.1d-1_x64-windows.list
---- Unsatisfied dependencies detected during ----
----     PLICEASE/Alien-Build-2.37.tar.gz     ----
    ExtUtils::MakeMaker [build_requires]
    ExtUtils::ParseXS [build_requires]
    File::Which [build_requires]
Running make test
  Make had some problems, won't test
  Delayed until after prerequisites
Running make install
  Make had some problems, won't install
  Delayed until after prerequisites
Running install for module 'ExtUtils::MakeMaker'
Running make for B/BI/BINGOS/ExtUtils-MakeMaker-7.58.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/B/BI/BINGOS/ExtUtils-MakeMaker-7.58.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/B/BI/BINGOS/CHECKSUMS
Checksum for /root/.cpan/sources/authors/id/B/BI/BINGOS/ExtUtils-MakeMaker-7.58.tar.gz ok
ExtUtils-MakeMaker-7.58/
ExtUtils-MakeMaker-7.58/my/
ExtUtils-MakeMaker-7.58/my/bundles.pm
ExtUtils-MakeMaker-7.58/bin/
ExtUtils-MakeMaker-7.58/bin/instmodsh
ExtUtils-MakeMaker-7.58/bundled/
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta/
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta/CPAN/
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta/CPAN/Meta.pm
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta/CPAN/Meta/
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta/CPAN/Meta/Prereqs.pm
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta/CPAN/Meta/Spec.pm
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta/CPAN/Meta/Converter.pm
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta/CPAN/Meta/Merge.pm
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta/CPAN/Meta/Validator.pm
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta/CPAN/Meta/Feature.pm
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta/CPAN/Meta/History.pm
ExtUtils-MakeMaker-7.58/bundled/Parse-CPAN-Meta/
ExtUtils-MakeMaker-7.58/bundled/Parse-CPAN-Meta/Parse/
ExtUtils-MakeMaker-7.58/bundled/Parse-CPAN-Meta/Parse/CPAN/
ExtUtils-MakeMaker-7.58/bundled/Parse-CPAN-Meta/Parse/CPAN/Meta.pm
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta-YAML/
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta-YAML/CPAN/
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta-YAML/CPAN/Meta/
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta-YAML/CPAN/Meta/YAML.pm
ExtUtils-MakeMaker-7.58/bundled/File-Temp/
ExtUtils-MakeMaker-7.58/bundled/File-Temp/File/
ExtUtils-MakeMaker-7.58/bundled/File-Temp/File/Temp.pm
ExtUtils-MakeMaker-7.58/bundled/ExtUtils-Manifest/
ExtUtils-MakeMaker-7.58/bundled/ExtUtils-Manifest/ExtUtils/
ExtUtils-MakeMaker-7.58/bundled/ExtUtils-Manifest/ExtUtils/Manifest.pm
ExtUtils-MakeMaker-7.58/bundled/ExtUtils-Manifest/ExtUtils/MANIFEST.SKIP
ExtUtils-MakeMaker-7.58/bundled/JSON-PP/
ExtUtils-MakeMaker-7.58/bundled/JSON-PP/JSON/
ExtUtils-MakeMaker-7.58/bundled/JSON-PP/JSON/PP.pm
ExtUtils-MakeMaker-7.58/bundled/JSON-PP/JSON/PP/
ExtUtils-MakeMaker-7.58/bundled/JSON-PP/JSON/PP/Boolean.pm
ExtUtils-MakeMaker-7.58/bundled/ExtUtils-Install/
ExtUtils-MakeMaker-7.58/bundled/ExtUtils-Install/ExtUtils/
ExtUtils-MakeMaker-7.58/bundled/ExtUtils-Install/ExtUtils/Install.pm
ExtUtils-MakeMaker-7.58/bundled/ExtUtils-Install/ExtUtils/Packlist.pm
ExtUtils-MakeMaker-7.58/bundled/ExtUtils-Install/ExtUtils/Installed.pm
ExtUtils-MakeMaker-7.58/bundled/Scalar-List-Utils/
ExtUtils-MakeMaker-7.58/bundled/Scalar-List-Utils/Scalar/
ExtUtils-MakeMaker-7.58/bundled/Scalar-List-Utils/Scalar/Util.pm
ExtUtils-MakeMaker-7.58/bundled/Scalar-List-Utils/Scalar/Util/
ExtUtils-MakeMaker-7.58/bundled/Scalar-List-Utils/Scalar/Util/PP.pm
ExtUtils-MakeMaker-7.58/bundled/Scalar-List-Utils/List/
ExtUtils-MakeMaker-7.58/bundled/Scalar-List-Utils/List/Util.pm
ExtUtils-MakeMaker-7.58/bundled/Scalar-List-Utils/List/Util/
ExtUtils-MakeMaker-7.58/bundled/Scalar-List-Utils/List/Util/PP.pm
ExtUtils-MakeMaker-7.58/bundled/README
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta-Requirements/
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta-Requirements/CPAN/
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta-Requirements/CPAN/Meta/
ExtUtils-MakeMaker-7.58/bundled/CPAN-Meta-Requirements/CPAN/Meta/Requirements.pm
ExtUtils-MakeMaker-7.58/META.json
ExtUtils-MakeMaker-7.58/README.packaging
ExtUtils-MakeMaker-7.58/MANIFEST
ExtUtils-MakeMaker-7.58/t/
ExtUtils-MakeMaker-7.58/t/unicode.t
ExtUtils-MakeMaker-7.58/t/fix_libs.t
ExtUtils-MakeMaker-7.58/t/META_for_testing.yml
ExtUtils-MakeMaker-7.58/t/miniperl.t
ExtUtils-MakeMaker-7.58/t/testdata/
ExtUtils-MakeMaker-7.58/t/testdata/reallylongdirectoryname/
ExtUtils-MakeMaker-7.58/t/testdata/reallylongdirectoryname/arch2/
ExtUtils-MakeMaker-7.58/t/testdata/reallylongdirectoryname/arch2/Config.pm
ExtUtils-MakeMaker-7.58/t/testdata/reallylongdirectoryname/arch1/
ExtUtils-MakeMaker-7.58/t/testdata/reallylongdirectoryname/arch1/Config.pm
ExtUtils-MakeMaker-7.58/t/installed_file.t
ExtUtils-MakeMaker-7.58/t/01perl_bugs.t
ExtUtils-MakeMaker-7.58/t/parse_abstract.t
ExtUtils-MakeMaker-7.58/t/testlib.t
ExtUtils-MakeMaker-7.58/t/test_boilerplate.t
ExtUtils-MakeMaker-7.58/t/metafile_data.t
ExtUtils-MakeMaker-7.58/t/Liblist.t
ExtUtils-MakeMaker-7.58/t/00compile.t
ExtUtils-MakeMaker-7.58/t/cd.t
ExtUtils-MakeMaker-7.58/t/eu_command.t
ExtUtils-MakeMaker-7.58/t/pm.t
ExtUtils-MakeMaker-7.58/t/META_for_testing.json
ExtUtils-MakeMaker-7.58/t/basic.t
ExtUtils-MakeMaker-7.58/t/dir_target.t
ExtUtils-MakeMaker-7.58/t/MM_OS2.t
ExtUtils-MakeMaker-7.58/t/echo.t
ExtUtils-MakeMaker-7.58/t/MM_Unix.t
ExtUtils-MakeMaker-7.58/t/min_perl_version.t
ExtUtils-MakeMaker-7.58/t/metafile_file.t
ExtUtils-MakeMaker-7.58/t/parse_version.t
ExtUtils-MakeMaker-7.58/t/02-xsdynamic.t
ExtUtils-MakeMaker-7.58/t/MM_Cygwin.t
ExtUtils-MakeMaker-7.58/t/problems.t
ExtUtils-MakeMaker-7.58/t/postamble.t
ExtUtils-MakeMaker-7.58/t/FIRST_MAKEFILE.t
ExtUtils-MakeMaker-7.58/t/MM_Any.t
ExtUtils-MakeMaker-7.58/t/Mkbootstrap.t
ExtUtils-MakeMaker-7.58/t/META_for_testing_tricky_version.yml
ExtUtils-MakeMaker-7.58/t/make.t
ExtUtils-MakeMaker-7.58/t/several_authors.t
ExtUtils-MakeMaker-7.58/t/prompt.t
ExtUtils-MakeMaker-7.58/t/fixin.t
ExtUtils-MakeMaker-7.58/t/backwards.t
ExtUtils-MakeMaker-7.58/t/prereq_print.t
ExtUtils-MakeMaker-7.58/t/MM_VMS.t
ExtUtils-MakeMaker-7.58/t/revision.t
ExtUtils-MakeMaker-7.58/t/split_command.t
ExtUtils-MakeMaker-7.58/t/is_of_type.t
ExtUtils-MakeMaker-7.58/t/prereq.t
ExtUtils-MakeMaker-7.58/t/INST_PREFIX.t
ExtUtils-MakeMaker-7.58/t/cp.t
ExtUtils-MakeMaker-7.58/t/writemakefile_args.t
ExtUtils-MakeMaker-7.58/t/MM_NW5.t
ExtUtils-MakeMaker-7.58/t/pod2man.t
ExtUtils-MakeMaker-7.58/t/lib/
ExtUtils-MakeMaker-7.58/t/lib/Test/
ExtUtils-MakeMaker-7.58/t/lib/Test/Simple.pm
ExtUtils-MakeMaker-7.58/t/lib/Test/Builder/
ExtUtils-MakeMaker-7.58/t/lib/Test/Builder/Module.pm
ExtUtils-MakeMaker-7.58/t/lib/Test/Builder/IO/
ExtUtils-MakeMaker-7.58/t/lib/Test/Builder/IO/Scalar.pm
ExtUtils-MakeMaker-7.58/t/lib/Test/More.pm
ExtUtils-MakeMaker-7.58/t/lib/Test/Builder.pm
ExtUtils-MakeMaker-7.58/t/lib/TieOut.pm
ExtUtils-MakeMaker-7.58/t/lib/TieIn.pm
ExtUtils-MakeMaker-7.58/t/lib/MakeMaker/
ExtUtils-MakeMaker-7.58/t/lib/MakeMaker/Test/
ExtUtils-MakeMaker-7.58/t/lib/MakeMaker/Test/NoXS.pm
ExtUtils-MakeMaker-7.58/t/lib/MakeMaker/Test/Setup/
ExtUtils-MakeMaker-7.58/t/lib/MakeMaker/Test/Setup/XS.pm
ExtUtils-MakeMaker-7.58/t/lib/MakeMaker/Test/Setup/BFD.pm
ExtUtils-MakeMaker-7.58/t/lib/MakeMaker/Test/Utils.pm
ExtUtils-MakeMaker-7.58/t/arch_check.t
ExtUtils-MakeMaker-7.58/t/INST.t
ExtUtils-MakeMaker-7.58/t/Liblist_Kid.t
ExtUtils-MakeMaker-7.58/t/pm_to_blib.t
ExtUtils-MakeMaker-7.58/t/os_unsupported.t
ExtUtils-MakeMaker-7.58/t/maketext_filter.t
ExtUtils-MakeMaker-7.58/t/hints.t
ExtUtils-MakeMaker-7.58/t/config.t
ExtUtils-MakeMaker-7.58/t/recurs.t
ExtUtils-MakeMaker-7.58/t/prefixify.t
ExtUtils-MakeMaker-7.58/t/meta_convert.t
ExtUtils-MakeMaker-7.58/t/VERSION_FROM.t
ExtUtils-MakeMaker-7.58/t/MM_BeOS.t
ExtUtils-MakeMaker-7.58/t/MM_Win32.t
ExtUtils-MakeMaker-7.58/t/build_man.t
ExtUtils-MakeMaker-7.58/t/WriteEmptyMakefile.t
ExtUtils-MakeMaker-7.58/t/03-xsstatic.t
ExtUtils-MakeMaker-7.58/t/MakeMaker_Parameters.t
ExtUtils-MakeMaker-7.58/t/vstrings.t
ExtUtils-MakeMaker-7.58/t/PL_FILES.t
ExtUtils-MakeMaker-7.58/t/INSTALL_BASE.t
ExtUtils-MakeMaker-7.58/t/oneliner.t
ExtUtils-MakeMaker-7.58/INSTALL
ExtUtils-MakeMaker-7.58/Changes
ExtUtils-MakeMaker-7.58/MANIFEST.SKIP
ExtUtils-MakeMaker-7.58/CONTRIBUTING
ExtUtils-MakeMaker-7.58/lib/
ExtUtils-MakeMaker-7.58/lib/ExtUtils/
ExtUtils-MakeMaker-7.58/lib/ExtUtils/Command.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/Command/
ExtUtils-MakeMaker-7.58/lib/ExtUtils/Command/MM.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_Win95.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/Mkbootstrap.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_DOS.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_VOS.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MakeMaker.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/Liblist/
ExtUtils-MakeMaker-7.58/lib/ExtUtils/Liblist/Kid.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_OS390.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_VMS.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/Mksymlists.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_OS2.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MY.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_UWIN.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_NW5.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/Liblist.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_Win32.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MakeMaker/
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MakeMaker/Config.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MakeMaker/version.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MakeMaker/version/
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MakeMaker/version/regex.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MakeMaker/version/vpp.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MakeMaker/FAQ.pod
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MakeMaker/Tutorial.pod
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MakeMaker/Locale.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_BeOS.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_QNX.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_Unix.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_Any.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_MacOS.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/testlib.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_Darwin.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_AIX.pm
ExtUtils-MakeMaker-7.58/lib/ExtUtils/MM_Cygwin.pm
ExtUtils-MakeMaker-7.58/README
ExtUtils-MakeMaker-7.58/META.yml
ExtUtils-MakeMaker-7.58/Makefile.PL

  CPAN.pm: Building B/BI/BINGOS/ExtUtils-MakeMaker-7.58.tar.gz

Using included version of JSON::PP (2.27203) as it is newer than the installed version (2.27200).
Using included version of CPAN::Meta::YAML (0.011) as it is newer than the installed version (0.008).
Using included version of CPAN::Meta (2.143240) as it is newer than the installed version (2.120921).
Using included version of CPAN::Meta::Requirements (2.131) as it is newer than the installed version (2.122).
Using included version of Parse::CPAN::Meta (1.4414) as it is newer than the installed version (1.4404).
Using included version of ExtUtils::Install (2.06) as it is newer than the installed version (1.54).
Using included version of ExtUtils::Manifest (1.70) as it is newer than the installed version (1.58).
Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for ExtUtils::MakeMaker
Writing MYMETA.yml and MYMETA.json
cp inc/ExtUtils/Manifest.pm blib/lib/ExtUtils/Manifest.pm
cp lib/ExtUtils/MM_VOS.pm blib/lib/ExtUtils/MM_VOS.pm
cp lib/ExtUtils/MM.pm blib/lib/ExtUtils/MM.pm
cp inc/JSON/PP.pm blib/lib/JSON/PP.pm
cp lib/ExtUtils/MM_UWIN.pm blib/lib/ExtUtils/MM_UWIN.pm
cp lib/ExtUtils/MM_DOS.pm blib/lib/ExtUtils/MM_DOS.pm
cp lib/ExtUtils/MM_Cygwin.pm blib/lib/ExtUtils/MM_Cygwin.pm
cp lib/ExtUtils/MM_Win95.pm blib/lib/ExtUtils/MM_Win95.pm
cp lib/ExtUtils/Liblist.pm blib/lib/ExtUtils/Liblist.pm
cp lib/ExtUtils/MM_Darwin.pm blib/lib/ExtUtils/MM_Darwin.pm
cp lib/ExtUtils/MM_AIX.pm blib/lib/ExtUtils/MM_AIX.pm
cp inc/CPAN/Meta/Requirements.pm blib/lib/CPAN/Meta/Requirements.pm
cp lib/ExtUtils/Liblist/Kid.pm blib/lib/ExtUtils/Liblist/Kid.pm
cp inc/ExtUtils/MANIFEST.SKIP blib/lib/ExtUtils/MANIFEST.SKIP
cp lib/ExtUtils/MM_NW5.pm blib/lib/ExtUtils/MM_NW5.pm
cp lib/ExtUtils/MM_OS390.pm blib/lib/ExtUtils/MM_OS390.pm
cp lib/ExtUtils/MakeMaker.pm blib/lib/ExtUtils/MakeMaker.pm
cp lib/ExtUtils/MM_OS2.pm blib/lib/ExtUtils/MM_OS2.pm
cp inc/CPAN/Meta/Feature.pm blib/lib/CPAN/Meta/Feature.pm
cp lib/ExtUtils/Command.pm blib/lib/ExtUtils/Command.pm
cp lib/ExtUtils/MM_Unix.pm blib/lib/ExtUtils/MM_Unix.pm
cp lib/ExtUtils/MM_Win32.pm blib/lib/ExtUtils/MM_Win32.pm
cp inc/ExtUtils/Installed.pm blib/lib/ExtUtils/Installed.pm
cp inc/JSON/PP/Boolean.pm blib/lib/JSON/PP/Boolean.pm
cp inc/CPAN/Meta/Spec.pm blib/lib/CPAN/Meta/Spec.pm
cp inc/CPAN/Meta/History.pm blib/lib/CPAN/Meta/History.pm
cp lib/ExtUtils/MY.pm blib/lib/ExtUtils/MY.pm
cp inc/ExtUtils/Packlist.pm blib/lib/ExtUtils/Packlist.pm
cp lib/ExtUtils/MM_MacOS.pm blib/lib/ExtUtils/MM_MacOS.pm
cp lib/ExtUtils/MM_VMS.pm blib/lib/ExtUtils/MM_VMS.pm
cp inc/CPAN/Meta/Merge.pm blib/lib/CPAN/Meta/Merge.pm
cp lib/ExtUtils/MM_BeOS.pm blib/lib/ExtUtils/MM_BeOS.pm
cp lib/ExtUtils/MM_QNX.pm blib/lib/ExtUtils/MM_QNX.pm
cp inc/CPAN/Meta/YAML.pm blib/lib/CPAN/Meta/YAML.pm
cp inc/CPAN/Meta/Converter.pm blib/lib/CPAN/Meta/Converter.pm
cp inc/ExtUtils/Install.pm blib/lib/ExtUtils/Install.pm
cp lib/ExtUtils/Command/MM.pm blib/lib/ExtUtils/Command/MM.pm
cp lib/ExtUtils/MakeMaker/Config.pm blib/lib/ExtUtils/MakeMaker/Config.pm
cp inc/CPAN/Meta.pm blib/lib/CPAN/Meta.pm
cp inc/CPAN/Meta/Prereqs.pm blib/lib/CPAN/Meta/Prereqs.pm
cp inc/Parse/CPAN/Meta.pm blib/lib/Parse/CPAN/Meta.pm
cp inc/CPAN/Meta/Validator.pm blib/lib/CPAN/Meta/Validator.pm
cp lib/ExtUtils/MM_Any.pm blib/lib/ExtUtils/MM_Any.pm
cp lib/ExtUtils/MakeMaker/Tutorial.pod blib/lib/ExtUtils/MakeMaker/Tutorial.pod
cp lib/ExtUtils/Mkbootstrap.pm blib/lib/ExtUtils/Mkbootstrap.pm
cp lib/ExtUtils/MakeMaker/FAQ.pod blib/lib/ExtUtils/MakeMaker/FAQ.pod
cp lib/ExtUtils/Mksymlists.pm blib/lib/ExtUtils/Mksymlists.pm
cp lib/ExtUtils/MakeMaker/version/regex.pm blib/lib/ExtUtils/MakeMaker/version/regex.pm
cp lib/ExtUtils/testlib.pm blib/lib/ExtUtils/testlib.pm
cp lib/ExtUtils/MakeMaker/Locale.pm blib/lib/ExtUtils/MakeMaker/Locale.pm
cp lib/ExtUtils/MakeMaker/version.pm blib/lib/ExtUtils/MakeMaker/version.pm
cp lib/ExtUtils/MakeMaker/version/vpp.pm blib/lib/ExtUtils/MakeMaker/version/vpp.pm
cp bin/instmodsh blib/script/instmodsh
"/usr/bin/perl" "-Iblib/arch" "-Iblib/lib" -MExtUtils::MY -e 'MY->fixin(shift)' -- blib/script/instmodsh
Manifying 1 pod document
Manifying 38 pod documents
Manifying 9 pod documents
  BINGOS/ExtUtils-MakeMaker-7.58.tar.gz
  /usr/bin/make -- OK
'YAML' not installed, will not store persistent state
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-Iblib/arch" "-Iblib/lib" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00compile.t ............. ok
t/01perl_bugs.t ........... ok
t/02-xsdynamic.t .......... ok
t/03-xsstatic.t ........... skipped: Shared perl library
t/arch_check.t ............ ok
t/backwards.t ............. ok
t/basic.t ................. ok
t/build_man.t ............. ok
t/cd.t .................... ok
t/config.t ................ ok
t/cp.t .................... ok
t/dir_target.t ............ ok
t/echo.t .................. ok
t/eu_command.t ............ ok
t/FIRST_MAKEFILE.t ........ ok
t/fix_libs.t .............. ok
t/fixin.t ................. ok
t/hints.t ................. ok
t/INST.t .................. ok
t/INST_PREFIX.t ........... ok
t/INSTALL_BASE.t .......... ok
t/installed_file.t ........ ok
t/is_of_type.t ............ ok
t/Liblist.t ............... ok
t/Liblist_Kid.t ........... ok
t/make.t .................. ok
t/MakeMaker_Parameters.t .. ok
t/maketext_filter.t ....... ok
t/meta_convert.t .......... ok
t/metafile_data.t ......... ok
t/metafile_file.t ......... ok
t/min_perl_version.t ...... ok
t/miniperl.t .............. skipped: miniperl test only necessary for the perl core
t/Mkbootstrap.t ........... ok
t/MM_Any.t ................ ok
t/MM_BeOS.t ............... skipped: This is not BeOS
t/MM_Cygwin.t ............. skipped: This is not cygwin
t/MM_NW5.t ................ skipped: This is not NW5
t/MM_OS2.t ................ skipped: This is not OS/2
t/MM_Unix.t ............... ok
t/MM_VMS.t ................ skipped: This is not VMS
t/MM_Win32.t .............. skipped: This is not Win32
t/oneliner.t .............. ok
t/os_unsupported.t ........ ok
t/parse_abstract.t ........ ok
t/parse_version.t ......... ok
t/PL_FILES.t .............. ok
t/pm.t .................... ok
t/pm_to_blib.t ............ ok
t/pod2man.t ............... ok
t/postamble.t ............. ok
t/prefixify.t ............. ok
t/prereq.t ................ ok
t/prereq_print.t .......... ok
t/problems.t .............. ok
t/prompt.t ................ ok
t/recurs.t ................ ok
t/revision.t .............. ok
t/several_authors.t ....... ok
t/split_command.t ......... ok
t/test_boilerplate.t ...... ok
t/testlib.t ............... ok
t/unicode.t ............... ok
t/VERSION_FROM.t .......... ok
t/vstrings.t .............. ok
t/WriteEmptyMakefile.t .... ok
t/writemakefile_args.t .... ok
All tests successful.
Files=67, Tests=1314, 33 wallclock secs ( 0.26 usr  0.08 sys + 20.60 cusr  5.06 csys = 26.00 CPU)
Result: PASS
  BINGOS/ExtUtils-MakeMaker-7.58.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/ExtUtils-MakeMaker-7.58-NFyNXM/blib/arch /root/.cpan/build/ExtUtils-MakeMaker-7.58-NFyNXM/blib/lib to PERL5LIB for 'install'
Manifying 1 pod document
Manifying 38 pod documents
Manifying 9 pod documents
Installing /usr/local/share/perl5/JSON/PP.pm
Installing /usr/local/share/perl5/CPAN/Meta.pm
Installing /usr/local/share/perl5/CPAN/Meta/Merge.pm
Installing /usr/local/share/perl5/CPAN/Meta/YAML.pm
Installing /usr/local/share/perl5/CPAN/Meta/Spec.pm
Installing /usr/local/share/perl5/CPAN/Meta/Feature.pm
Installing /usr/local/share/perl5/CPAN/Meta/Converter.pm
Installing /usr/local/share/perl5/CPAN/Meta/Validator.pm
Installing /usr/local/share/perl5/CPAN/Meta/History.pm
Installing /usr/local/share/perl5/CPAN/Meta/Prereqs.pm
Installing /usr/local/share/perl5/CPAN/Meta/Requirements.pm
Installing /usr/local/share/perl5/Parse/CPAN/Meta.pm
Installing /usr/local/share/perl5/ExtUtils/MM_DOS.pm
Installing /usr/local/share/perl5/ExtUtils/MM_Win32.pm
Installing /usr/local/share/perl5/ExtUtils/MM_OS390.pm
Installing /usr/local/share/perl5/ExtUtils/Mksymlists.pm
Installing /usr/local/share/perl5/ExtUtils/Manifest.pm
Installing /usr/local/share/perl5/ExtUtils/Command.pm
Installing /usr/local/share/perl5/ExtUtils/MM_QNX.pm
Installing /usr/local/share/perl5/ExtUtils/MM_AIX.pm
Installing /usr/local/share/perl5/ExtUtils/MM_Any.pm
Installing /usr/local/share/perl5/ExtUtils/MM_NW5.pm
Installing /usr/local/share/perl5/ExtUtils/MM_VMS.pm
Installing /usr/local/share/perl5/ExtUtils/MM_Win95.pm
Installing /usr/local/share/perl5/ExtUtils/Liblist.pm
Installing /usr/local/share/perl5/ExtUtils/MM_Darwin.pm
Installing /usr/local/share/perl5/ExtUtils/Mkbootstrap.pm
Installing /usr/local/share/perl5/ExtUtils/Installed.pm
Installing /usr/local/share/perl5/ExtUtils/MM_Unix.pm
Installing /usr/local/share/perl5/ExtUtils/testlib.pm
Installing /usr/local/share/perl5/ExtUtils/MM_VOS.pm
Installing /usr/local/share/perl5/ExtUtils/MY.pm
Installing /usr/local/share/perl5/ExtUtils/Install.pm
Installing /usr/local/share/perl5/ExtUtils/MM.pm
Installing /usr/local/share/perl5/ExtUtils/MM_OS2.pm
Installing /usr/local/share/perl5/ExtUtils/MANIFEST.SKIP
Installing /usr/local/share/perl5/ExtUtils/MM_UWIN.pm
Installing /usr/local/share/perl5/ExtUtils/MM_BeOS.pm
Installing /usr/local/share/perl5/ExtUtils/MM_MacOS.pm
Installing /usr/local/share/perl5/ExtUtils/Packlist.pm
Installing /usr/local/share/perl5/ExtUtils/MakeMaker.pm
Installing /usr/local/share/perl5/ExtUtils/MM_Cygwin.pm
Installing /usr/local/share/perl5/ExtUtils/Command/MM.pm
Installing /usr/local/share/perl5/ExtUtils/Liblist/Kid.pm
Installing /usr/local/share/perl5/ExtUtils/MakeMaker/version.pm
Installing /usr/local/share/perl5/ExtUtils/MakeMaker/Locale.pm
Installing /usr/local/share/perl5/ExtUtils/MakeMaker/Tutorial.pod
Installing /usr/local/share/perl5/ExtUtils/MakeMaker/Config.pm
Installing /usr/local/share/perl5/ExtUtils/MakeMaker/FAQ.pod
Installing /usr/local/share/perl5/ExtUtils/MakeMaker/version/vpp.pm
Installing /usr/local/share/perl5/ExtUtils/MakeMaker/version/regex.pm
Installing /usr/local/share/man/man1/instmodsh.1
Installing /usr/local/share/man/man3/ExtUtils::MM_Cygwin.3pm
Installing /usr/local/share/man/man3/CPAN::Meta::History.3pm
Installing /usr/local/share/man/man3/ExtUtils::MakeMaker::FAQ.3pm
Installing /usr/local/share/man/man3/ExtUtils::Liblist.3pm
Installing /usr/local/share/man/man3/CPAN::Meta::Feature.3pm
Installing /usr/local/share/man/man3/ExtUtils::Mkbootstrap.3pm
Installing /usr/local/share/man/man3/JSON::PP.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_NW5.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_Unix.3pm
Installing /usr/local/share/man/man3/ExtUtils::Mksymlists.3pm
Installing /usr/local/share/man/man3/ExtUtils::Command::MM.3pm
Installing /usr/local/share/man/man3/CPAN::Meta::Merge.3pm
Installing /usr/local/share/man/man3/JSON::PP::Boolean.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_DOS.3pm
Installing /usr/local/share/man/man3/ExtUtils::MakeMaker::Locale.3pm
Installing /usr/local/share/man/man3/ExtUtils::MY.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_BeOS.3pm
Installing /usr/local/share/man/man3/ExtUtils::MakeMaker::Config.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_VMS.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_MacOS.3pm
Installing /usr/local/share/man/man3/ExtUtils::testlib.3pm
Installing /usr/local/share/man/man3/ExtUtils::Install.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM.3pm
Installing /usr/local/share/man/man3/CPAN::Meta::YAML.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_OS390.3pm
Installing /usr/local/share/man/man3/CPAN::Meta::Validator.3pm
Installing /usr/local/share/man/man3/Parse::CPAN::Meta.3pm
Installing /usr/local/share/man/man3/CPAN::Meta::Converter.3pm
Installing /usr/local/share/man/man3/ExtUtils::Installed.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_OS2.3pm
Installing /usr/local/share/man/man3/ExtUtils::Packlist.3pm
Installing /usr/local/share/man/man3/ExtUtils::MakeMaker.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_Win32.3pm
Installing /usr/local/share/man/man3/ExtUtils::Manifest.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_Win95.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_Any.3pm
Installing /usr/local/share/man/man3/CPAN::Meta::Prereqs.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_QNX.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_AIX.3pm
Installing /usr/local/share/man/man3/ExtUtils::Command.3pm
Installing /usr/local/share/man/man3/CPAN::Meta.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_VOS.3pm
Installing /usr/local/share/man/man3/CPAN::Meta::Requirements.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_UWIN.3pm
Installing /usr/local/share/man/man3/ExtUtils::MakeMaker::Tutorial.3pm
Installing /usr/local/share/man/man3/ExtUtils::MM_Darwin.3pm
Installing /usr/local/share/man/man3/CPAN::Meta::Spec.3pm
Installing /usr/local/bin/instmodsh
Appending installation info to /usr/lib64/perl5/perllocal.pod
  BINGOS/ExtUtils-MakeMaker-7.58.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'ExtUtils::ParseXS'
Running make for S/SM/SMUELLER/ExtUtils-ParseXS-3.35.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/S/SM/SMUELLER/ExtUtils-ParseXS-3.35.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/S/SM/SMUELLER/CHECKSUMS
Checksum for /root/.cpan/sources/authors/id/S/SM/SMUELLER/ExtUtils-ParseXS-3.35.tar.gz ok
ExtUtils-ParseXS-3.35/
ExtUtils-ParseXS-3.35/META.yml
ExtUtils-ParseXS-3.35/lib/
ExtUtils-ParseXS-3.35/lib/ExtUtils/
ExtUtils-ParseXS-3.35/lib/ExtUtils/ParseXS.pod
ExtUtils-ParseXS-3.35/lib/ExtUtils/ParseXS/
ExtUtils-ParseXS-3.35/lib/ExtUtils/ParseXS/Constants.pm
ExtUtils-ParseXS-3.35/lib/ExtUtils/ParseXS/CountLines.pm
ExtUtils-ParseXS-3.35/lib/ExtUtils/ParseXS/Utilities.pm
ExtUtils-ParseXS-3.35/lib/ExtUtils/ParseXS/Eval.pm
ExtUtils-ParseXS-3.35/lib/ExtUtils/ParseXS.pm
ExtUtils-ParseXS-3.35/lib/ExtUtils/xsubpp
ExtUtils-ParseXS-3.35/lib/ExtUtils/Typemaps/
ExtUtils-ParseXS-3.35/lib/ExtUtils/Typemaps/OutputMap.pm
ExtUtils-ParseXS-3.35/lib/ExtUtils/Typemaps/Cmd.pm
ExtUtils-ParseXS-3.35/lib/ExtUtils/Typemaps/Type.pm
ExtUtils-ParseXS-3.35/lib/ExtUtils/Typemaps/InputMap.pm
ExtUtils-ParseXS-3.35/lib/ExtUtils/Typemaps.pm
ExtUtils-ParseXS-3.35/MANIFEST
ExtUtils-ParseXS-3.35/t/
ExtUtils-ParseXS-3.35/t/XSTest.xs
ExtUtils-ParseXS-3.35/t/XSUsage.xs
ExtUtils-ParseXS-3.35/t/115-avoid-noise.t
ExtUtils-ParseXS-3.35/t/002-more.t
ExtUtils-ParseXS-3.35/t/XSMore.xs
ExtUtils-ParseXS-3.35/t/XSInclude.xsh
ExtUtils-ParseXS-3.35/t/103-tidy_type.t
ExtUtils-ParseXS-3.35/t/lib/
ExtUtils-ParseXS-3.35/t/lib/PrimitiveCapture.pm
ExtUtils-ParseXS-3.35/t/lib/TypemapTest/
ExtUtils-ParseXS-3.35/t/lib/TypemapTest/Foo.pm
ExtUtils-ParseXS-3.35/t/lib/ExtUtils/
ExtUtils-ParseXS-3.35/t/lib/ExtUtils/Typemaps/
ExtUtils-ParseXS-3.35/t/lib/ExtUtils/Typemaps/Test.pm
ExtUtils-ParseXS-3.35/t/lib/IncludeTester.pm
ExtUtils-ParseXS-3.35/t/515-t-cmd.t
ExtUtils-ParseXS-3.35/t/114-blurt_death_Warn.t
ExtUtils-ParseXS-3.35/t/512-t-file.t
ExtUtils-ParseXS-3.35/t/105-valid_proto_string.t
ExtUtils-ParseXS-3.35/t/001-basic.t
ExtUtils-ParseXS-3.35/t/data/
ExtUtils-ParseXS-3.35/t/data/b.typemap
ExtUtils-ParseXS-3.35/t/data/other.typemap
ExtUtils-ParseXS-3.35/t/data/confl_repl.typemap
ExtUtils-ParseXS-3.35/t/data/confl_skip.typemap
ExtUtils-ParseXS-3.35/t/data/conflicting.typemap
ExtUtils-ParseXS-3.35/t/data/combined.typemap
ExtUtils-ParseXS-3.35/t/data/perl.typemap
ExtUtils-ParseXS-3.35/t/data/simple.typemap
ExtUtils-ParseXS-3.35/t/513-t-merge.t
ExtUtils-ParseXS-3.35/t/109-standard_XS_defs.t
ExtUtils-ParseXS-3.35/t/517-t-targetable.t
ExtUtils-ParseXS-3.35/t/111-analyze_preprocessor_statements.t
ExtUtils-ParseXS-3.35/t/104-map_type.t
ExtUtils-ParseXS-3.35/t/102-trim_whitespace.t
ExtUtils-ParseXS-3.35/t/XSTest.pm
ExtUtils-ParseXS-3.35/t/106-process_typemaps.t
ExtUtils-ParseXS-3.35/t/XSWarn.xs
ExtUtils-ParseXS-3.35/t/typemap
ExtUtils-ParseXS-3.35/t/600-t-compat.t
ExtUtils-ParseXS-3.35/t/516-t-clone.t
ExtUtils-ParseXS-3.35/t/112-set_cond.t
ExtUtils-ParseXS-3.35/t/pseudotypemap1
ExtUtils-ParseXS-3.35/t/110-assign_func_args.t
ExtUtils-ParseXS-3.35/t/108-map_type.t
ExtUtils-ParseXS-3.35/t/514-t-embed.t
ExtUtils-ParseXS-3.35/t/113-check_cond_preproc_statements.t
ExtUtils-ParseXS-3.35/t/XSUsage.pm
ExtUtils-ParseXS-3.35/t/003-usage.t
ExtUtils-ParseXS-3.35/t/511-t-whitespace.t
ExtUtils-ParseXS-3.35/t/510-t-bare.t
ExtUtils-ParseXS-3.35/t/101-standard_typemap_locations.t
ExtUtils-ParseXS-3.35/t/501-t-compile.t
ExtUtils-ParseXS-3.35/META.json
ExtUtils-ParseXS-3.35/INSTALL
ExtUtils-ParseXS-3.35/Makefile.PL
ExtUtils-ParseXS-3.35/Changes
ExtUtils-ParseXS-3.35/README

  CPAN.pm: Building S/SM/SMUELLER/ExtUtils-ParseXS-3.35.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for ExtUtils::ParseXS
Writing MYMETA.yml and MYMETA.json
cp lib/ExtUtils/Typemaps/InputMap.pm blib/lib/ExtUtils/Typemaps/InputMap.pm
cp lib/ExtUtils/ParseXS.pod blib/lib/ExtUtils/ParseXS.pod
cp lib/ExtUtils/ParseXS/Utilities.pm blib/lib/ExtUtils/ParseXS/Utilities.pm
cp lib/ExtUtils/Typemaps/Type.pm blib/lib/ExtUtils/Typemaps/Type.pm
cp lib/ExtUtils/ParseXS/Constants.pm blib/lib/ExtUtils/ParseXS/Constants.pm
cp lib/ExtUtils/xsubpp blib/lib/ExtUtils/xsubpp
cp lib/ExtUtils/Typemaps/OutputMap.pm blib/lib/ExtUtils/Typemaps/OutputMap.pm
cp lib/ExtUtils/ParseXS.pm blib/lib/ExtUtils/ParseXS.pm
cp lib/ExtUtils/ParseXS/CountLines.pm blib/lib/ExtUtils/ParseXS/CountLines.pm
cp lib/ExtUtils/Typemaps/Cmd.pm blib/lib/ExtUtils/Typemaps/Cmd.pm
cp lib/ExtUtils/ParseXS/Eval.pm blib/lib/ExtUtils/ParseXS/Eval.pm
cp lib/ExtUtils/Typemaps.pm blib/lib/ExtUtils/Typemaps.pm
cp lib/ExtUtils/xsubpp blib/script/xsubpp
"/usr/bin/perl" -MExtUtils::MY -e 'MY->fixin(shift)' -- blib/script/xsubpp
Manifying 1 pod document
Manifying 9 pod documents
  SMUELLER/ExtUtils-ParseXS-3.35.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/001-basic.t ............................ 1/17 XSTest.c: In function ‘XS_XSTest_T_BOOL_2’:
XSTest.c:306: warning: unused variable ‘RETVAL’
t/001-basic.t ............................ ok
t/002-more.t ............................. 1/29 XSMore.c: In function ‘XS_XSMore_nil’:
XSMore.c:516: warning: unused variable ‘items’
t/002-more.t ............................. ok
t/003-usage.t ............................ 1/24 XSUsage.c: In function ‘XS_XSUsage_two’:
XSUsage.c:202: warning: unused variable ‘ix’
XSUsage.c: In function ‘XS_XSUsage_four’:
XSUsage.c:238: warning: unused variable ‘items’
t/003-usage.t ............................ ok
t/101-standard_typemap_locations.t ....... ok
t/102-trim_whitespace.t .................. ok
t/103-tidy_type.t ........................ ok
t/104-map_type.t ......................... ok
t/105-valid_proto_string.t ............... ok
t/106-process_typemaps.t ................. ok
t/108-map_type.t ......................... ok
t/109-standard_XS_defs.t ................. ok
t/110-assign_func_args.t ................. ok
t/111-analyze_preprocessor_statements.t .. ok
t/112-set_cond.t ......................... ok
t/113-check_cond_preproc_statements.t .... ok
t/114-blurt_death_Warn.t ................. ok
t/115-avoid-noise.t ...................... ok
t/501-t-compile.t ........................ ok
t/510-t-bare.t ........................... ok
t/511-t-whitespace.t ..................... ok
t/512-t-file.t ........................... ok
t/513-t-merge.t .......................... ok
t/514-t-embed.t .......................... ok
t/515-t-cmd.t ............................ ok
t/516-t-clone.t .......................... ok
t/517-t-targetable.t ..................... ok
t/600-t-compat.t ......................... ok
All tests successful.
Files=27, Tests=264,  1 wallclock secs ( 0.07 usr  0.03 sys +  1.31 cusr  0.28 csys =  1.69 CPU)
Result: PASS
  SMUELLER/ExtUtils-ParseXS-3.35.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/ExtUtils-ParseXS-3.35-MOietH/blib/arch /root/.cpan/build/ExtUtils-ParseXS-3.35-MOietH/blib/lib to PERL5LIB for 'install'
Manifying 1 pod document
Manifying 9 pod documents
Installing /usr/local/share/perl5/ExtUtils/xsubpp
Installing /usr/local/share/perl5/ExtUtils/ParseXS.pod
Installing /usr/local/share/perl5/ExtUtils/ParseXS.pm
Installing /usr/local/share/perl5/ExtUtils/Typemaps.pm
Installing /usr/local/share/perl5/ExtUtils/ParseXS/Constants.pm
Installing /usr/local/share/perl5/ExtUtils/ParseXS/Eval.pm
Installing /usr/local/share/perl5/ExtUtils/ParseXS/CountLines.pm
Installing /usr/local/share/perl5/ExtUtils/ParseXS/Utilities.pm
Installing /usr/local/share/perl5/ExtUtils/Typemaps/Cmd.pm
Installing /usr/local/share/perl5/ExtUtils/Typemaps/OutputMap.pm
Installing /usr/local/share/perl5/ExtUtils/Typemaps/InputMap.pm
Installing /usr/local/share/perl5/ExtUtils/Typemaps/Type.pm
Installing /usr/local/share/man/man1/xsubpp.1
Installing /usr/local/share/man/man3/ExtUtils::ParseXS::Constants.3pm
Installing /usr/local/share/man/man3/ExtUtils::Typemaps::InputMap.3pm
Installing /usr/local/share/man/man3/ExtUtils::ParseXS.3pm
Installing /usr/local/share/man/man3/ExtUtils::ParseXS::Utilities.3pm
Installing /usr/local/share/man/man3/ExtUtils::ParseXS::Eval.3pm
Installing /usr/local/share/man/man3/ExtUtils::Typemaps.3pm
Installing /usr/local/share/man/man3/ExtUtils::Typemaps::OutputMap.3pm
Installing /usr/local/share/man/man3/ExtUtils::Typemaps::Type.3pm
Installing /usr/local/share/man/man3/ExtUtils::Typemaps::Cmd.3pm
Installing /usr/local/bin/xsubpp
Appending installation info to /usr/lib64/perl5/perllocal.pod
  SMUELLER/ExtUtils-ParseXS-3.35.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'File::Which'
Running make for P/PL/PLICEASE/File-Which-1.23.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/P/PL/PLICEASE/File-Which-1.23.tar.gz
Checksum for /root/.cpan/sources/authors/id/P/PL/PLICEASE/File-Which-1.23.tar.gz ok
File-Which-1.23
File-Which-1.23/README
File-Which-1.23/Changes
File-Which-1.23/LICENSE
File-Which-1.23/INSTALL
File-Which-1.23/dist.ini
File-Which-1.23/META.yml
File-Which-1.23/MANIFEST
File-Which-1.23/META.json
File-Which-1.23/author.yml
File-Which-1.23/t
File-Which-1.23/t/01_use.t
File-Which-1.23/t/00_diag.t
File-Which-1.23/Makefile.PL
File-Which-1.23/t/file_which.t
File-Which-1.23/xt/author
File-Which-1.23/xt/author/eol.t
File-Which-1.23/xt/author/pod.t
File-Which-1.23/lib/File
File-Which-1.23/lib/File/Which.pm
File-Which-1.23/xt/author/strict.t
File-Which-1.23/xt/release
File-Which-1.23/xt/release/fixme.t
File-Which-1.23/xt/author/no_tabs.t
File-Which-1.23/xt/author/version.t
File-Which-1.23/corpus/test-bin-unix
File-Which-1.23/corpus/test-bin-unix/0
File-Which-1.23/corpus/test-bin-unix/all
File-Which-1.23/xt/author/pod_coverage.t
File-Which-1.23/corpus/test-bin-win
File-Which-1.23/corpus/test-bin-win/0.exe
File-Which-1.23/corpus/test-bin-unix/test3
File-Which-1.23/corpus/test-bin-win/all.exe
File-Which-1.23/corpus/test-bin-win/all.bat
File-Which-1.23/corpus/test-bin-win/test1.exe
File-Which-1.23/corpus/test-bin-win/test2.bat
File-Which-1.23/corpus/test-bin-unix/README.txt
File-Which-1.23/xt/author/pod_spelling_common.t
File-Which-1.23/xt/author/pod_spelling_system.t
File-Which-1.23/corpus/test-bin-unix/test4
File-Which-1.23/corpus/test-bin-unix/test4/foo.txt

  CPAN.pm: Building P/PL/PLICEASE/File-Which-1.23.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for File::Which
Writing MYMETA.yml and MYMETA.json
cp lib/File/Which.pm blib/lib/File/Which.pm
Manifying 1 pod document
  PLICEASE/File-Which-1.23.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00_diag.t ..... 1/1 #
#
#
# HARNESS_ACTIVE=1
# HARNESS_VERSION=3.17
# LANG=en_US.UTF-8
# PERL5LIB=/root/.cpan/build/File-Which-1.23-Ea_yBV/blib/lib:/root/.cpan/build/File-Which-1.23-Ea_yBV/blib/arch:
# PERL5OPT=
# PERL5_CPANPLUS_IS_RUNNING=27355
# PERL5_CPAN_IS_RUNNING=27355
# PERL_DL_NONLAZY=1
# SHELL=/bin/bash
#
#
#
# PERL5LIB path
# /root/.cpan/build/File-Which-1.23-Ea_yBV/blib/lib
# /root/.cpan/build/File-Which-1.23-Ea_yBV/blib/arch
#
#
#
# perl                5.010001
# ExtUtils::MakeMaker 7.58
# Test::More          0.98
#
#
#
t/00_diag.t ..... ok
t/01_use.t ...... ok
t/file_which.t .. ok
All tests successful.
Files=3, Tests=21,  1 wallclock secs ( 0.02 usr  0.01 sys +  0.09 cusr  0.01 csys =  0.13 CPU)
Result: PASS
  PLICEASE/File-Which-1.23.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/File-Which-1.23-Ea_yBV/blib/arch /root/.cpan/build/File-Which-1.23-Ea_yBV/blib/lib to PERL5LIB for 'install'
Manifying 1 pod document
Installing /usr/local/share/perl5/File/Which.pm
Installing /usr/local/share/man/man3/File::Which.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  PLICEASE/File-Which-1.23.tar.gz
  /usr/bin/make install  -- OK
Running make for P/PL/PLICEASE/Alien-Build-2.37.tar.gz

  CPAN.pm: Building P/PL/PLICEASE/Alien-Build-2.37.tar.gz

gcc -I/usr/lib64/perl5/CORE -fPIC -c -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic -o inc/trivial.o inc/trivial.c
Checking if your kit is complete...
Looks good
Warning: prerequisite Capture::Tiny 0.17 not found.
Warning: prerequisite FFI::CheckLib 0.11 not found.
Warning: prerequisite File::chdir 0 not found.
Warning: prerequisite List::Util 1.33 not found. We have 1.21.
Warning: prerequisite Path::Tiny 0.077 not found.
Warning: prerequisite Test2::API 1.302096 not found.
Warning: prerequisite Test2::V0 0.000060 not found.
Generating a Unix-style Makefile
Writing Makefile for Alien::Build
Writing MYMETA.yml and MYMETA.json
---- Unsatisfied dependencies detected during ----
----     PLICEASE/Alien-Build-2.37.tar.gz     ----
    Capture::Tiny [requires]
    Test2::API [requires]
    File::chdir [requires]
    List::Util [requires]
    Test2::V0 [build_requires]
    FFI::CheckLib [requires]
    Path::Tiny [requires]
Running make test
  Delayed until after prerequisites
Running make install
  Delayed until after prerequisites
Running install for module 'Capture::Tiny'
Running make for D/DA/DAGOLDEN/Capture-Tiny-0.48.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/D/DA/DAGOLDEN/Capture-Tiny-0.48.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/D/DA/DAGOLDEN/CHECKSUMS
Checksum for /root/.cpan/sources/authors/id/D/DA/DAGOLDEN/Capture-Tiny-0.48.tar.gz ok
Capture-Tiny-0.48/
Capture-Tiny-0.48/LICENSE
Capture-Tiny-0.48/cpanfile
Capture-Tiny-0.48/Changes
Capture-Tiny-0.48/MANIFEST
Capture-Tiny-0.48/perlcritic.rc
Capture-Tiny-0.48/CONTRIBUTING.mkdn
Capture-Tiny-0.48/t/
Capture-Tiny-0.48/xt/
Capture-Tiny-0.48/README
Capture-Tiny-0.48/Todo
Capture-Tiny-0.48/examples/
Capture-Tiny-0.48/META.yml
Capture-Tiny-0.48/lib/
Capture-Tiny-0.48/Makefile.PL
Capture-Tiny-0.48/META.json
Capture-Tiny-0.48/dist.ini
Capture-Tiny-0.48/lib/Capture/
Capture-Tiny-0.48/lib/Capture/Tiny.pm
Capture-Tiny-0.48/examples/tee.pl
Capture-Tiny-0.48/examples/rt-58208.pl
Capture-Tiny-0.48/xt/author/
Capture-Tiny-0.48/xt/release/
Capture-Tiny-0.48/xt/release/distmeta.t
Capture-Tiny-0.48/xt/author/critic.t
Capture-Tiny-0.48/xt/author/minimum-version.t
Capture-Tiny-0.48/xt/author/test-version.t
Capture-Tiny-0.48/xt/author/00-compile.t
Capture-Tiny-0.48/xt/author/pod-syntax.t
Capture-Tiny-0.48/xt/author/portability.t
Capture-Tiny-0.48/xt/author/pod-spell.t
Capture-Tiny-0.48/xt/author/pod-coverage.t
Capture-Tiny-0.48/t/19-relayering.t
Capture-Tiny-0.48/t/24-all-badtied.t
Capture-Tiny-0.48/t/08-stdin-closed.t
Capture-Tiny-0.48/t/13-stdout-tied.t
Capture-Tiny-0.48/t/21-stderr-badtie.t
Capture-Tiny-0.48/t/20-stdout-badtie.t
Capture-Tiny-0.48/t/09-preserve-exit-code.t
Capture-Tiny-0.48/t/12-stdin-string.t
Capture-Tiny-0.48/t/02-capture.t
Capture-Tiny-0.48/t/22-stdin-badtie.t
Capture-Tiny-0.48/t/23-all-tied.t
Capture-Tiny-0.48/t/01-Capture-Tiny.t
Capture-Tiny-0.48/t/16-catch-errors.t
Capture-Tiny-0.48/t/00-report-prereqs.t
Capture-Tiny-0.48/t/lib/
Capture-Tiny-0.48/t/25-cap-fork.t
Capture-Tiny-0.48/t/11-stderr-string.t
Capture-Tiny-0.48/t/10-stdout-string.t
Capture-Tiny-0.48/t/06-stdout-closed.t
Capture-Tiny-0.48/t/07-stderr-closed.t
Capture-Tiny-0.48/t/00-report-prereqs.dd
Capture-Tiny-0.48/t/18-custom-capture.t
Capture-Tiny-0.48/t/17-pass-results.t
Capture-Tiny-0.48/t/03-tee.t
Capture-Tiny-0.48/t/14-stderr-tied.t
Capture-Tiny-0.48/t/15-stdin-tied.t
Capture-Tiny-0.48/t/lib/Cases.pm
Capture-Tiny-0.48/t/lib/Utils.pm
Capture-Tiny-0.48/t/lib/TieLC.pm
Capture-Tiny-0.48/t/lib/TieEvil.pm

  CPAN.pm: Building D/DA/DAGOLDEN/Capture-Tiny-0.48.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for Capture::Tiny
Writing MYMETA.yml and MYMETA.json
cp lib/Capture/Tiny.pm blib/lib/Capture/Tiny.pm
Manifying 1 pod document
  DAGOLDEN/Capture-Tiny-0.48.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00-report-prereqs.t ...... #
# Versions for all modules listed in MYMETA.json (including optional ones):
#
# === Configure Requires ===
#
#     Module              Want Have
#     ------------------- ---- ----
#     ExtUtils::MakeMaker 6.17 7.58
#
# === Build Requires ===
#
#     Module              Want Have
#     ------------------- ---- ----
#     ExtUtils::MakeMaker  any 7.58
#
# === Test Requires ===
#
#     Module              Want Have
#     ------------------- ---- ----
#     ExtUtils::MakeMaker  any 7.58
#     File::Spec           any 3.30
#     IO::File             any 1.14
#     Test::More          0.62 0.98
#     lib                  any 0.62
#
# === Test Recommends ===
#
#     Module         Want     Have
#     ---------- -------- --------
#     CPAN::Meta 2.120900 2.143240
#
# === Runtime Requires ===
#
#     Module       Want Have
#     ------------ ---- ----
#     Carp          any 1.11
#     Exporter      any 5.63
#     File::Spec    any 3.30
#     File::Temp    any 0.22
#     IO::Handle    any 1.28
#     Scalar::Util  any 1.21
#     strict        any 1.04
#     warnings      any 1.06
#
t/00-report-prereqs.t ...... ok
t/01-Capture-Tiny.t ........ ok
t/02-capture.t ............. ok
t/03-tee.t ................. ok
t/06-stdout-closed.t ....... ok
t/07-stderr-closed.t ....... ok
t/08-stdin-closed.t ........ ok
t/09-preserve-exit-code.t .. ok
t/10-stdout-string.t ....... ok
t/11-stderr-string.t ....... ok
t/12-stdin-string.t ........ ok
t/13-stdout-tied.t ......... ok
t/14-stderr-tied.t ......... ok
t/15-stdin-tied.t .......... ok
t/16-catch-errors.t ........ ok
t/17-pass-results.t ........ ok
t/18-custom-capture.t ...... ok
t/19-relayering.t .......... ok
t/20-stdout-badtie.t ....... ok
t/21-stderr-badtie.t ....... ok
t/22-stdin-badtie.t ........ ok
t/23-all-tied.t ............ ok
t/24-all-badtied.t ......... ok
t/25-cap-fork.t ............ ok
All tests successful.
Files=24, Tests=12005, 20 wallclock secs ( 1.06 usr  0.07 sys + 12.72 cusr  8.91 csys = 22.76 CPU)
Result: PASS
  DAGOLDEN/Capture-Tiny-0.48.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/Capture-Tiny-0.48-YRNVlY/blib/arch /root/.cpan/build/Capture-Tiny-0.48-YRNVlY/blib/lib to PERL5LIB for 'install'
Manifying 1 pod document
Installing /usr/local/share/perl5/Capture/Tiny.pm
Installing /usr/local/share/man/man3/Capture::Tiny.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  DAGOLDEN/Capture-Tiny-0.48.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'Test2::API'
Running make for E/EX/EXODIST/Test-Simple-1.302183.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/E/EX/EXODIST/Test-Simple-1.302183.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/E/EX/EXODIST/CHECKSUMS
Checksum for /root/.cpan/sources/authors/id/E/EX/EXODIST/Test-Simple-1.302183.tar.gz ok
Test-Simple-1.302183
Test-Simple-1.302183/README
Test-Simple-1.302183/LICENSE
Test-Simple-1.302183/Changes
Test-Simple-1.302183/MANIFEST
Test-Simple-1.302183/dist.ini
Test-Simple-1.302183/cpanfile
Test-Simple-1.302183/META.yml
Test-Simple-1.302183/lib
Test-Simple-1.302183/lib/ok.pm
Test-Simple-1.302183/META.json
Test-Simple-1.302183/README.md
Test-Simple-1.302183/Makefile.PL
Test-Simple-1.302183/appveyor.yml
Test-Simple-1.302183/lib/Test2.pm
Test-Simple-1.302183/t
Test-Simple-1.302183/t/HashBase.t
Test-Simple-1.302183/t/00compile.t
Test-Simple-1.302183/t/00-report.t
Test-Simple-1.302183/t/lib
Test-Simple-1.302183/t/lib/Dummy.pm
Test-Simple-1.302183/t/Legacy
Test-Simple-1.302183/t/Legacy/auto.t
Test-Simple-1.302183/t/Legacy/fork.t
Test-Simple-1.302183/t/Legacy/plan.t
Test-Simple-1.302183/t/Legacy/note.t
Test-Simple-1.302183/t/Legacy/diag.t
Test-Simple-1.302183/t/Legacy/todo.t
Test-Simple-1.302183/t/Legacy/skip.t
Test-Simple-1.302183/t/Legacy/fail.t
Test-Simple-1.302183/t/Legacy/utf8.t
Test-Simple-1.302183/t/Legacy/died.t
Test-Simple-1.302183/t/Legacy/More.t
Test-Simple-1.302183/t/Legacy/exit.t
Test-Simple-1.302183/t/lib/MyTest.pm
Test-Simple-1.302183/t/lib/TieOut.pm
Test-Simple-1.302183/t/lib/SigDie.pm
Test-Simple-1.302183/examples
Test-Simple-1.302183/examples/tools.t
Test-Simple-1.302183/lib/Test2
Test-Simple-1.302183/lib/Test2/IPC.pm
Test-Simple-1.302183/lib/Test2/API.pm
Test-Simple-1.302183/lib/Test2/Hub.pm
Test-Simple-1.302183/lib/Test
Test-Simple-1.302183/lib/Test/More.pm
Test-Simple-1.302183/t/Legacy/undef.t
Test-Simple-1.302183/t/Legacy/extra.t
Test-Simple-1.302183/t/Legacy/depth.t
Test-Simple-1.302183/t/lib/SkipAll.pm
Test-Simple-1.302183/examples/tools.pl
Test-Simple-1.302183/lib/Test2/Util.pm
Test-Simple-1.302183/t/Legacy/import.t
Test-Simple-1.302183/t/Legacy/simple.t
Test-Simple-1.302183/t/Legacy/strays.t
Test-Simple-1.302183/t/Legacy/useing.t
Test-Simple-1.302183/t/Legacy/cmp_ok.t
Test-Simple-1.302183/t/Legacy/new_ok.t
Test-Simple-1.302183/t/Legacy/c_flag.t
Test-Simple-1.302183/t/Legacy/eq_set.t
Test-Simple-1.302183/t/Legacy/buffer.t
Test-Simple-1.302183/t/Legacy/use_ok.t
Test-Simple-1.302183/t/lib/Dev
Test-Simple-1.302183/t/lib/Dev/Null.pm
Test-Simple-1.302183/examples/indent.pl
Test-Simple-1.302183/examples/subtest.t
Test-Simple-1.302183/lib/Test2/Event.pm
Test-Simple-1.302183/lib/Test/Simple.pm
Test-Simple-1.302183/lib/Test/Tester.pm
Test-Simple-1.302183/lib/Test/use
Test-Simple-1.302183/lib/Test/use/ok.pm
Test-Simple-1.302183/t/Legacy/capture.t
Test-Simple-1.302183/t/Legacy/explain.t
Test-Simple-1.302183/t/Legacy/no_plan.t
Test-Simple-1.302183/t/Legacy/threads.t
Test-Simple-1.302183/t/Legacy/missing.t
Test-Simple-1.302183/t/Legacy/skipall.t
Test-Simple-1.302183/t/lib/SmallTest.pm
Test-Simple-1.302183/lib/Test/Builder.pm
Test-Simple-1.302183/t/Legacy/overload.t
Test-Simple-1.302183/t/Legacy/run_test.t
Test-Simple-1.302183/t/Legacy/bad_plan.t
Test-Simple-1.302183/t/Legacy/fail_one.t
Test-Simple-1.302183/t/Legacy/01-basic.t
Test-Simple-1.302183/t/Legacy/plan_bad.t
Test-Simple-1.302183/t/Legacy/no_tests.t
Test-Simple-1.302183/t/Legacy/versions.t
Test-Simple-1.302183/t/Legacy/bail_out.t
Test-Simple-1.302183/t/Legacy/Bugs
Test-Simple-1.302183/t/Legacy/Bugs/629.t
Test-Simple-1.302183/t/Legacy/Bugs/600.t
Test-Simple-1.302183/t/lib/MyOverload.pm
Test-Simple-1.302183/t/lib/NoExporter.pm
Test-Simple-1.302183/t/zzz-check-breaks.t
Test-Simple-1.302183/t/Legacy/extra_one.t
Test-Simple-1.302183/t/Legacy/fail-like.t
Test-Simple-1.302183/t/Legacy/fail-more.t
Test-Simple-1.302183/t/Test2/legacy
Test-Simple-1.302183/t/Test2/legacy/TAP.t
Test-Simple-1.302183/xt/author
Test-Simple-1.302183/xt/author/pod-spell.t
Test-Simple-1.302183/lib/Test2/Event
Test-Simple-1.302183/lib/Test2/Event/V2.pm
Test-Simple-1.302183/lib/Test2/Event/Ok.pm
Test-Simple-1.302183/lib/Test/Tutorial.pod
Test-Simple-1.302183/t/Legacy/require_ok.t
Test-Simple-1.302183/t/Legacy/subtest
Test-Simple-1.302183/t/Legacy/subtest/do.t
Test-Simple-1.302183/t/Test2/modules
Test-Simple-1.302183/t/Test2/modules/Hub.t
Test-Simple-1.302183/t/Test2/modules/IPC.t
Test-Simple-1.302183/t/Test2/modules/API.t
Test-Simple-1.302183/lib/Test2/Formatter.pm
Test-Simple-1.302183/lib/Test2/API
Test-Simple-1.302183/lib/Test2/API/Stack.pm
Test-Simple-1.302183/t/Legacy/check_tests.t
Test-Simple-1.302183/t/Legacy/filehandles.t
Test-Simple-1.302183/t/Legacy/Builder
Test-Simple-1.302183/t/Legacy/Builder/try.t
Test-Simple-1.302183/t/Legacy/Simple
Test-Simple-1.302183/t/Legacy/Simple/load.t
Test-Simple-1.302183/t/Legacy/subtest/die.t
Test-Simple-1.302183/t/Test2/modules/Util.t
Test-Simple-1.302183/xt/author/pod-syntax.t
Test-Simple-1.302183/lib/Test2/EventFacet.pm
Test-Simple-1.302183/lib/Test2/Util
Test-Simple-1.302183/lib/Test2/Util/Trace.pm
Test-Simple-1.302183/lib/Test2/Event/Diag.pm
Test-Simple-1.302183/lib/Test2/Event/Fail.pm
Test-Simple-1.302183/lib/Test2/Event/Note.pm
Test-Simple-1.302183/lib/Test2/Event/Bail.pm
Test-Simple-1.302183/lib/Test2/Event/Plan.pm
Test-Simple-1.302183/lib/Test2/Event/Pass.pm
Test-Simple-1.302183/lib/Test2/Event/Skip.pm
Test-Simple-1.302183/lib/Test2/Tools
Test-Simple-1.302183/lib/Test2/Tools/Tiny.pm
Test-Simple-1.302183/lib/Test2/IPC
Test-Simple-1.302183/lib/Test2/IPC/Driver.pm
Test-Simple-1.302183/t/Legacy/plan_no_plan.t
Test-Simple-1.302183/t/Legacy/thread_taint.t
Test-Simple-1.302183/t/Legacy/BEGIN_use_ok.t
Test-Simple-1.302183/t/Legacy/Builder/carp.t
Test-Simple-1.302183/t/Legacy/subtest/fork.t
Test-Simple-1.302183/t/Legacy/subtest/plan.t
Test-Simple-1.302183/t/Legacy/subtest/todo.t
Test-Simple-1.302183/t/Legacy/subtest/args.t
Test-Simple-1.302183/t/regression
Test-Simple-1.302183/t/regression/812-todo.t
Test-Simple-1.302183/t/Test2/behavior
Test-Simple-1.302183/t/Test2/behavior/uuid.t
Test-Simple-1.302183/t/Test2/modules/Event.t
Test-Simple-1.302183/lib/Test2/Transition.pod
Test-Simple-1.302183/lib/Test2/Hub
Test-Simple-1.302183/lib/Test2/Hub/Subtest.pm
Test-Simple-1.302183/lib/Test2/API/Context.pm
Test-Simple-1.302183/t/Legacy/plan_skip_all.t
Test-Simple-1.302183/t/Legacy/circular_data.t
Test-Simple-1.302183/t/Legacy/Builder/reset.t
Test-Simple-1.302183/t/Legacy/Builder/is_fh.t
Test-Simple-1.302183/t/Legacy/Test2
Test-Simple-1.302183/t/Legacy/Test2/Subtest.t
Test-Simple-1.302183/t/Legacy/subtest/basic.t
Test-Simple-1.302183/t/Legacy/subtest/wstat.t
Test-Simple-1.302183/t/Test2/behavior/Taint.t
Test-Simple-1.302183/lib/Test2/API/Instance.pm
Test-Simple-1.302183/lib/Test2/API/Breakage.pm
Test-Simple-1.302183/t/Legacy/plan_is_noplan.t
Test-Simple-1.302183/t/Legacy/is_deeply_fail.t
Test-Simple-1.302183/t/Legacy/harness_active.t
Test-Simple-1.302183/t/Legacy/no_log_results.t
Test-Simple-1.302183/t/Legacy/Builder/create.t
Test-Simple-1.302183/t/Legacy/Builder/output.t
Test-Simple-1.302183/t/Legacy/Builder/ok_obj.t
Test-Simple-1.302183/t/Legacy/Regression
Test-Simple-1.302183/t/Legacy/Regression/637.t
Test-Simple-1.302183/t/Legacy/subtest/events.t
Test-Simple-1.302183/t/regression/fork_first.t
Test-Simple-1.302183/lib/Test2/Util/HashBase.pm
Test-Simple-1.302183/lib/Test2/Event/Generic.pm
Test-Simple-1.302183/lib/Test2/Event/Subtest.pm
Test-Simple-1.302183/lib/Test2/Event/Waiting.pm
Test-Simple-1.302183/lib/Test2/Formatter
Test-Simple-1.302183/lib/Test2/Formatter/TAP.pm
Test-Simple-1.302183/lib/Test/Builder
Test-Simple-1.302183/lib/Test/Builder/Module.pm
Test-Simple-1.302183/lib/Test/Builder/Tester.pm
Test-Simple-1.302183/lib/Test/Tester
Test-Simple-1.302183/lib/Test/Tester/Capture.pm
Test-Simple-1.302183/t/Legacy/478-cmp_ok_hash.t
Test-Simple-1.302183/t/Legacy/Builder/no_diag.t
Test-Simple-1.302183/t/Legacy/Builder/details.t
Test-Simple-1.302183/t/Legacy/Builder/Builder.t
Test-Simple-1.302183/t/Legacy/Tester
Test-Simple-1.302183/t/Legacy/Tester/tbt_09do.t
Test-Simple-1.302183/t/Legacy/subtest/threads.t
Test-Simple-1.302183/t/Test2/regression
Test-Simple-1.302183/t/Test2/regression/gh_16.t
Test-Simple-1.302183/t/Test2/behavior/err_var.t
Test-Simple-1.302183/t/Test2/modules/Event
Test-Simple-1.302183/t/Test2/modules/Event/V2.t
Test-Simple-1.302183/t/Test2/modules/Event/Ok.t
Test-Simple-1.302183/t/lib/Test/Simple
Test-Simple-1.302183/t/lib/Test/Simple/Catch.pm
Test-Simple-1.302183/lib/Test2/Event/Encoding.pm
Test-Simple-1.302183/lib/Test2/EventFacet
Test-Simple-1.302183/lib/Test2/EventFacet/Hub.pm
Test-Simple-1.302183/lib/Test/Tester/Delegate.pm
Test-Simple-1.302183/t/Legacy/BEGIN_require_ok.t
Test-Simple-1.302183/t/Legacy/overload_threads.t
Test-Simple-1.302183/t/Legacy/explain_err_vars.t
Test-Simple-1.302183/t/Legacy/Builder/has_plan.t
Test-Simple-1.302183/t/Legacy/Tester/tbt_03die.t
Test-Simple-1.302183/t/Legacy/subtest/callback.t
Test-Simple-1.302183/t/Legacy/subtest/bail_out.t
Test-Simple-1.302183/t/regression/errors_facet.t
Test-Simple-1.302183/t/Test2/modules/API
Test-Simple-1.302183/t/Test2/modules/API/Stack.t
Test-Simple-1.302183/lib/Test2/Event/Exception.pm
Test-Simple-1.302183/lib/Test2/Hub/Interceptor.pm
Test-Simple-1.302183/lib/Test2/EventFacet/Info.pm
Test-Simple-1.302183/lib/Test2/EventFacet/Plan.pm
Test-Simple-1.302183/lib/Test2/EventFacet/Meta.pm
Test-Simple-1.302183/lib/Test/Builder/TodoDiag.pm
Test-Simple-1.302183/t/Legacy/is_deeply_dne_bug.t
Test-Simple-1.302183/t/Legacy/Builder/has_plan2.t
Test-Simple-1.302183/t/Legacy/Builder/no_header.t
Test-Simple-1.302183/t/Legacy/Builder/no_ending.t
Test-Simple-1.302183/t/Legacy/Tester/tbt_07args.t
Test-Simple-1.302183/t/Legacy/subtest/predicate.t
Test-Simple-1.302183/t/Legacy/subtest/singleton.t
Test-Simple-1.302183/t/regression/inherit_trace.t
Test-Simple-1.302183/t/Test2/behavior/intercept.t
Test-Simple-1.302183/t/Test2/behavior/Formatter.t
Test-Simple-1.302183/t/Test2/modules/EventFacet.t
Test-Simple-1.302183/t/Test2/modules/Util
Test-Simple-1.302183/t/Test2/modules/Util/Trace.t
Test-Simple-1.302183/t/Test2/modules/Event/Pass.t
Test-Simple-1.302183/t/Test2/modules/Event/Skip.t
Test-Simple-1.302183/t/Test2/modules/Event/Note.t
Test-Simple-1.302183/t/Test2/modules/Event/Plan.t
Test-Simple-1.302183/t/Test2/modules/Event/Diag.t
Test-Simple-1.302183/t/Test2/modules/Event/Fail.t
Test-Simple-1.302183/t/Test2/modules/Event/Bail.t
Test-Simple-1.302183/t/Test2/modules/Tools
Test-Simple-1.302183/t/Test2/modules/Tools/Tiny.t
Test-Simple-1.302183/t/Test2/modules/IPC
Test-Simple-1.302183/t/Test2/modules/IPC/Driver.t
Test-Simple-1.302183/lib/Test2/EventFacet/Error.pm
Test-Simple-1.302183/lib/Test2/EventFacet/Trace.pm
Test-Simple-1.302183/lib/Test2/EventFacet/About.pm
Test-Simple-1.302183/lib/Test2/IPC/Driver
Test-Simple-1.302183/lib/Test2/IPC/Driver/Files.pm
Test-Simple-1.302183/lib/Test/Builder/Formatter.pm
Test-Simple-1.302183/lib/Test/Builder/IO
Test-Simple-1.302183/lib/Test/Builder/IO/Scalar.pm
Test-Simple-1.302183/t/Legacy/Builder/is_passing.t
Test-Simple-1.302183/t/Legacy/Tester/tbt_01basic.t
Test-Simple-1.302183/t/Test2/behavior/init_croak.t
Test-Simple-1.302183/t/Test2/modules/Hub
Test-Simple-1.302183/t/Test2/modules/Hub/Subtest.t
Test-Simple-1.302183/t/Test2/modules/API/Context.t
Test-Simple-1.302183/lib/Test2/Util/ExternalMeta.pm
Test-Simple-1.302183/lib/Test2/Event/TAP
Test-Simple-1.302183/lib/Test2/Event/TAP/Version.pm
Test-Simple-1.302183/lib/Test2/EventFacet/Assert.pm
Test-Simple-1.302183/lib/Test2/EventFacet/Render.pm
Test-Simple-1.302183/lib/Test2/EventFacet/Parent.pm
Test-Simple-1.302183/t/Legacy/Builder/maybe_regex.t
Test-Simple-1.302183/t/Legacy/Regression/6_cmp_ok.t
Test-Simple-1.302183/t/Legacy/subtest/for_do_t.test
Test-Simple-1.302183/t/regression/662-tbt-no-plan.t
Test-Simple-1.302183/t/regression/todo_and_facets.t
Test-Simple-1.302183/t/Test2/behavior/no_load_api.t
Test-Simple-1.302183/t/Test2/modules/API/Instance.t
Test-Simple-1.302183/t/Test2/modules/API/Breakage.t
Test-Simple-1.302183/t/lib/Test/Builder
Test-Simple-1.302183/t/lib/Test/Builder/NoOutput.pm
Test-Simple-1.302183/lib/Test2/Util/Facets2Legacy.pm
Test-Simple-1.302183/lib/Test2/EventFacet/Control.pm
Test-Simple-1.302183/lib/Test2/EventFacet/Amnesty.pm
Test-Simple-1.302183/t/Legacy/plan_shouldnt_import.t
Test-Simple-1.302183/t/Legacy/00test_harness_check.t
Test-Simple-1.302183/t/Legacy/Builder/done_testing.t
Test-Simple-1.302183/t/Legacy/Builder/current_test.t
Test-Simple-1.302183/t/Legacy/Tester/tbt_08subtest.t
Test-Simple-1.302183/t/Legacy/subtest/line_numbers.t
Test-Simple-1.302183/t/regression/817-subtest-todo.t
Test-Simple-1.302183/t/Test2/behavior/Subtest_plan.t
Test-Simple-1.302183/t/Test2/behavior/Subtest_todo.t
Test-Simple-1.302183/t/Test2/modules/Event/Subtest.t
Test-Simple-1.302183/t/Test2/modules/Event/Waiting.t
Test-Simple-1.302183/t/Test2/modules/Event/Generic.t
Test-Simple-1.302183/t/Test2/modules/Formatter
Test-Simple-1.302183/t/Test2/modules/Formatter/TAP.t
Test-Simple-1.302183/lib/Test2/API/InterceptResult.pm
Test-Simple-1.302183/lib/Test/Builder/Tester
Test-Simple-1.302183/lib/Test/Builder/Tester/Color.pm
Test-Simple-1.302183/lib/Test/Tester/CaptureRunner.pm
Test-Simple-1.302183/t/Legacy/Builder/reset_outputs.t
Test-Simple-1.302183/t/Legacy/Regression/is_capture.t
Test-Simple-1.302183/t/Legacy/Regression/736_use_ok.t
Test-Simple-1.302183/t/Legacy/Tester/tbt_05faildiag.t
Test-Simple-1.302183/t/Legacy/Tester/tbt_04line_num.t
Test-Simple-1.302183/t/Legacy/subtest/implicit_done.t
Test-Simple-1.302183/t/Test2/behavior/disable_ipc_c.t
Test-Simple-1.302183/t/Test2/behavior/special_names.t
Test-Simple-1.302183/t/Test2/behavior/disable_ipc_b.t
Test-Simple-1.302183/t/Test2/behavior/disable_ipc_d.t
Test-Simple-1.302183/t/Test2/behavior/disable_ipc_a.t
Test-Simple-1.302183/t/Test2/modules/Event/Encoding.t
Test-Simple-1.302183/t/Test2/acceptance
Test-Simple-1.302183/t/Test2/acceptance/try_it_todo.t
Test-Simple-1.302183/t/Test2/acceptance/try_it_plan.t
Test-Simple-1.302183/t/Test2/acceptance/try_it_fork.t
Test-Simple-1.302183/t/Test2/acceptance/try_it_skip.t
Test-Simple-1.302183/t/Legacy/is_deeply_with_threads.t
Test-Simple-1.302183/t/Legacy/Builder/no_plan_at_all.t
Test-Simple-1.302183/t/Legacy/Tester/tbt_06errormess.t
Test-Simple-1.302183/t/Legacy/Tester/tbt_02fhrestore.t
Test-Simple-1.302183/t/regression/642_persistent_end.t
Test-Simple-1.302183/t/regression/no_name_in_subtest.t
Test-Simple-1.302183/t/Test2/behavior/Subtest_events.t
Test-Simple-1.302183/t/Test2/modules/Event/Exception.t
Test-Simple-1.302183/t/Test2/modules/Hub/Interceptor.t
Test-Simple-1.302183/t/Test2/modules/EventFacet
Test-Simple-1.302183/t/Test2/modules/EventFacet/Plan.t
Test-Simple-1.302183/t/Test2/modules/EventFacet/Meta.t
Test-Simple-1.302183/t/Test2/modules/EventFacet/Info.t
Test-Simple-1.302183/lib/Test2/EventFacet/Info
Test-Simple-1.302183/lib/Test2/EventFacet/Info/Table.pm
Test-Simple-1.302183/t/Legacy/Tester/tbt_09do_script.pl
Test-Simple-1.302183/t/Test2/behavior/trace_signature.t
Test-Simple-1.302183/t/Test2/behavior/subtest_bailout.t
Test-Simple-1.302183/t/Test2/modules/EventFacet/Error.t
Test-Simple-1.302183/t/Test2/modules/EventFacet/About.t
Test-Simple-1.302183/t/Test2/modules/EventFacet/Trace.t
Test-Simple-1.302183/t/Test2/modules/IPC/Driver
Test-Simple-1.302183/t/Test2/modules/IPC/Driver/Files.t
Test-Simple-1.302183/t/Legacy/Regression/789-read-only.t
Test-Simple-1.302183/t/regression/684-nested_todo_diag.t
Test-Simple-1.302183/t/regression/757-reset_in_subtest.t
Test-Simple-1.302183/t/Test2/behavior/ipc_wait_timeout.t
Test-Simple-1.302183/t/Test2/behavior/Subtest_callback.t
Test-Simple-1.302183/t/Test2/modules/Util/ExternalMeta.t
Test-Simple-1.302183/t/Test2/modules/Event/TAP
Test-Simple-1.302183/t/Test2/modules/Event/TAP/Version.t
Test-Simple-1.302183/t/Test2/modules/EventFacet/Parent.t
Test-Simple-1.302183/t/Test2/modules/EventFacet/Assert.t
Test-Simple-1.302183/t/Test2/acceptance/try_it_threads.t
Test-Simple-1.302183/t/Test2/acceptance/try_it_no_plan.t
Test-Simple-1.302183/lib/Test2/API/InterceptResult
Test-Simple-1.302183/lib/Test2/API/InterceptResult/Hub.pm
Test-Simple-1.302183/t/regression/builder_does_not_init.t
Test-Simple-1.302183/t/regression/862-intercept_tb_todo.t
Test-Simple-1.302183/t/Test2/modules/Util/Facets2Legacy.t
Test-Simple-1.302183/t/Test2/modules/EventFacet/Amnesty.t
Test-Simple-1.302183/t/Test2/modules/EventFacet/Control.t
Test-Simple-1.302183/t/Legacy_And_Test2
Test-Simple-1.302183/t/Legacy_And_Test2/hidden_warnings.t
Test-Simple-1.302183/t/Legacy/dont_overwrite_die_handler.t
Test-Simple-1.302183/t/Legacy/tbm_doesnt_set_exported_to.t
Test-Simple-1.302183/t/Legacy/Regression/683_thread_todo.t
Test-Simple-1.302183/t/regression/696-intercept_skip_all.t
Test-Simple-1.302183/t/Test2/regression/693_ipc_ordering.t
Test-Simple-1.302183/t/Test2/modules/API/InterceptResult.t
Test-Simple-1.302183/t/Legacy_And_Test2/diag_event_on_ok.t
Test-Simple-1.302183/lib/Test2/API/InterceptResult/Event.pm
Test-Simple-1.302183/lib/Test2/API/InterceptResult/Facet.pm
Test-Simple-1.302183/t/Legacy/Builder/done_testing_double.t
Test-Simple-1.302183/t/Test2/behavior/run_subtest_inherit.t
Test-Simple-1.302183/t/Legacy_And_Test2/preload_diag_note.t
Test-Simple-1.302183/lib/Test2/Hub/Interceptor
Test-Simple-1.302183/lib/Test2/Hub/Interceptor/Terminator.pm
Test-Simple-1.302183/t/Legacy/Builder/fork_with_new_stdout.t
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/exit.plx
Test-Simple-1.302183/t/Test2/regression/746-forking-subtest.t
Test-Simple-1.302183/t/Test2/acceptance/try_it_done_testing.t
Test-Simple-1.302183/t/Legacy_And_Test2/builder_loaded_late.t
Test-Simple-1.302183/t/Legacy_And_Test2/thread_init_warning.t
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/death.plx
Test-Simple-1.302183/lib/Test2/API/InterceptResult/Squasher.pm
Test-Simple-1.302183/t/Legacy/Builder/done_testing_with_plan.t
Test-Simple-1.302183/t/Test2/regression/ipc_files_abort_exit.t
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/extras.plx
Test-Simple-1.302183/t/regression/694_note_diag_return_values.t
Test-Simple-1.302183/t/regression/721-nested-streamed-subtest.t
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/too_few.plx
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/success.plx
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/require.plx
Test-Simple-1.302183/t/Legacy/Builder/done_testing_with_number.t
Test-Simple-1.302183/t/Test2/behavior/nested_context_exception.t
Test-Simple-1.302183/t/Test2/behavior/Subtest_buffer_formatter.t
Test-Simple-1.302183/t/Test2/modules/API/InterceptResult
Test-Simple-1.302183/t/Test2/modules/API/InterceptResult/Event.t
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/one_fail.plx
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/two_fail.plx
Test-Simple-1.302183/t/Legacy/Builder/current_test_without_plan.t
Test-Simple-1.302183/t/Legacy/Builder/done_testing_with_no_plan.t
Test-Simple-1.302183/t/Test2/modules/Hub/Interceptor
Test-Simple-1.302183/t/Test2/modules/Hub/Interceptor/Terminator.t
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/five_fail.plx
Test-Simple-1.302183/t/Legacy/Builder/done_testing_plan_mismatch.t
Test-Simple-1.302183/t/regression/buffered_subtest_plan_buffered.t
Test-Simple-1.302183/t/Test2/modules/API/InterceptResult/Squasher.t
Test-Simple-1.302183/t/Legacy/Regression/870-experimental-warnings.t
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/too_few_fail.plx
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/death_in_eval.plx
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/pre_plan_death.plx
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/last_minute_death.plx
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/death_with_handler.plx
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/missing_done_testing.plx
Test-Simple-1.302183/t/lib/Test/Simple/sample_tests/one_fail_without_plan.plx

  CPAN.pm: Building E/EX/EXODIST/Test-Simple-1.302183.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for Test::Simple
Writing MYMETA.yml and MYMETA.json
cp lib/Test2/Event.pm blib/lib/Test2/Event.pm
cp lib/Test2/API/InterceptResult/Facet.pm blib/lib/Test2/API/InterceptResult/Facet.pm
cp lib/Test2/API/InterceptResult/Event.pm blib/lib/Test2/API/InterceptResult/Event.pm
cp lib/Test/Tester/Capture.pm blib/lib/Test/Tester/Capture.pm
cp lib/Test/Tester.pm blib/lib/Test/Tester.pm
cp lib/Test/Simple.pm blib/lib/Test/Simple.pm
cp lib/Test2/API/Instance.pm blib/lib/Test2/API/Instance.pm
cp lib/Test/Builder/TodoDiag.pm blib/lib/Test/Builder/TodoDiag.pm
cp lib/Test2/Event/Fail.pm blib/lib/Test2/Event/Fail.pm
cp lib/Test2/API.pm blib/lib/Test2/API.pm
cp lib/Test/use/ok.pm blib/lib/Test/use/ok.pm
cp lib/Test/Builder.pm blib/lib/Test/Builder.pm
cp lib/Test/Tester/Delegate.pm blib/lib/Test/Tester/Delegate.pm
cp lib/Test/More.pm blib/lib/Test/More.pm
cp lib/Test2/Event/TAP/Version.pm blib/lib/Test2/Event/TAP/Version.pm
cp lib/Test2/Event/Skip.pm blib/lib/Test2/Event/Skip.pm
cp lib/Test/Builder/Formatter.pm blib/lib/Test/Builder/Formatter.pm
cp lib/Test2/Event/Exception.pm blib/lib/Test2/Event/Exception.pm
cp lib/Test2/Event/Subtest.pm blib/lib/Test2/Event/Subtest.pm
cp lib/Test/Builder/Tester.pm blib/lib/Test/Builder/Tester.pm
cp lib/Test2/API/InterceptResult.pm blib/lib/Test2/API/InterceptResult.pm
cp lib/Test/Tutorial.pod blib/lib/Test/Tutorial.pod
cp lib/Test2/API/Context.pm blib/lib/Test2/API/Context.pm
cp lib/Test2/Event/Plan.pm blib/lib/Test2/Event/Plan.pm
cp lib/Test2/Event/Ok.pm blib/lib/Test2/Event/Ok.pm
cp lib/Test2/API/InterceptResult/Squasher.pm blib/lib/Test2/API/InterceptResult/Squasher.pm
cp lib/Test2/Event/Pass.pm blib/lib/Test2/Event/Pass.pm
cp lib/Test2/Event/Bail.pm blib/lib/Test2/Event/Bail.pm
cp lib/Test/Builder/Tester/Color.pm blib/lib/Test/Builder/Tester/Color.pm
cp lib/Test2/Event/Diag.pm blib/lib/Test2/Event/Diag.pm
cp lib/Test2/Event/Generic.pm blib/lib/Test2/Event/Generic.pm
cp lib/Test/Builder/Module.pm blib/lib/Test/Builder/Module.pm
cp lib/Test2/API/Breakage.pm blib/lib/Test2/API/Breakage.pm
cp lib/Test2/API/Stack.pm blib/lib/Test2/API/Stack.pm
cp lib/Test/Tester/CaptureRunner.pm blib/lib/Test/Tester/CaptureRunner.pm
cp lib/Test2/API/InterceptResult/Hub.pm blib/lib/Test2/API/InterceptResult/Hub.pm
cp lib/Test2/Event/Encoding.pm blib/lib/Test2/Event/Encoding.pm
cp lib/Test2.pm blib/lib/Test2.pm
cp lib/Test/Builder/IO/Scalar.pm blib/lib/Test/Builder/IO/Scalar.pm
cp lib/Test2/Event/Note.pm blib/lib/Test2/Event/Note.pm
cp lib/Test2/Event/V2.pm blib/lib/Test2/Event/V2.pm
cp lib/ok.pm blib/lib/ok.pm
cp lib/Test2/Hub.pm blib/lib/Test2/Hub.pm
cp lib/Test2/EventFacet/Meta.pm blib/lib/Test2/EventFacet/Meta.pm
cp lib/Test2/EventFacet/Error.pm blib/lib/Test2/EventFacet/Error.pm
cp lib/Test2/IPC/Driver/Files.pm blib/lib/Test2/IPC/Driver/Files.pm
cp lib/Test2/IPC/Driver.pm blib/lib/Test2/IPC/Driver.pm
cp lib/Test2/EventFacet/Hub.pm blib/lib/Test2/EventFacet/Hub.pm
cp lib/Test2/Event/Waiting.pm blib/lib/Test2/Event/Waiting.pm
cp lib/Test2/Hub/Interceptor.pm blib/lib/Test2/Hub/Interceptor.pm
cp lib/Test2/EventFacet/Trace.pm blib/lib/Test2/EventFacet/Trace.pm
cp lib/Test2/EventFacet/Control.pm blib/lib/Test2/EventFacet/Control.pm
cp lib/Test2/Formatter.pm blib/lib/Test2/Formatter.pm
cp lib/Test2/EventFacet/Render.pm blib/lib/Test2/EventFacet/Render.pm
cp lib/Test2/EventFacet.pm blib/lib/Test2/EventFacet.pm
cp lib/Test2/Hub/Subtest.pm blib/lib/Test2/Hub/Subtest.pm
cp lib/Test2/EventFacet/Assert.pm blib/lib/Test2/EventFacet/Assert.pm
cp lib/Test2/Transition.pod blib/lib/Test2/Transition.pod
cp lib/Test2/Util/HashBase.pm blib/lib/Test2/Util/HashBase.pm
cp lib/Test2/Util/ExternalMeta.pm blib/lib/Test2/Util/ExternalMeta.pm
cp lib/Test2/EventFacet/About.pm blib/lib/Test2/EventFacet/About.pm
cp lib/Test2/Tools/Tiny.pm blib/lib/Test2/Tools/Tiny.pm
cp lib/Test2/EventFacet/Info/Table.pm blib/lib/Test2/EventFacet/Info/Table.pm
cp lib/Test2/Util.pm blib/lib/Test2/Util.pm
cp lib/Test2/EventFacet/Parent.pm blib/lib/Test2/EventFacet/Parent.pm
cp lib/Test2/EventFacet/Plan.pm blib/lib/Test2/EventFacet/Plan.pm
cp lib/Test2/Formatter/TAP.pm blib/lib/Test2/Formatter/TAP.pm
cp lib/Test2/Util/Facets2Legacy.pm blib/lib/Test2/Util/Facets2Legacy.pm
cp lib/Test2/Hub/Interceptor/Terminator.pm blib/lib/Test2/Hub/Interceptor/Terminator.pm
cp lib/Test2/EventFacet/Info.pm blib/lib/Test2/EventFacet/Info.pm
cp lib/Test2/IPC.pm blib/lib/Test2/IPC.pm
cp lib/Test2/Util/Trace.pm blib/lib/Test2/Util/Trace.pm
cp lib/Test2/EventFacet/Amnesty.pm blib/lib/Test2/EventFacet/Amnesty.pm
Manifying 36 pod documents
Manifying 34 pod documents
Manifying 1 pod document
  EXODIST/Test-Simple-1.302183.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t t/Legacy/*.t t/Legacy/Bugs/*.t t/Legacy/Builder/*.t t/Legacy/Regression/*.t t/Legacy/Simple/*.t t/Legacy/Test2/*.t t/Legacy/Tester/*.t t/Legacy/subtest/*.t t/Legacy_And_Test2/*.t t/Test2/acceptance/*.t t/Test2/behavior/*.t t/Test2/legacy/*.t t/Test2/modules/*.t t/Test2/modules/API/*.t t/Test2/modules/API/InterceptResult/*.t t/Test2/modules/Event/*.t t/Test2/modules/Event/TAP/*.t t/Test2/modules/EventFacet/*.t t/Test2/modules/Formatter/*.t t/Test2/modules/Hub/*.t t/Test2/modules/Hub/Interceptor/*.t t/Test2/modules/IPC/*.t t/Test2/modules/IPC/Driver/*.t t/Test2/modules/Tools/*.t t/Test2/modules/Util/*.t t/Test2/regression/*.t t/regression/*.t
t/00-report.t .................................... 1/?
# DIAGNOSTICS INFO IN CASE OF FAILURE:

# Perl: 5.010001

# CAPABILITIES:
# CAN_FORK         Yes
# CAN_REALLY_FORK  Yes
# CAN_THREAD       Yes

# DEPENDENCIES:
# Carp          1.11
# File::Spec    3.3
# File::Temp    0.22
# PerlIO        1.06
# Scalar::Util  1.21
# Storable      2.20
# Test2         1.302183
# overload      1.07
# threads       1.82
# utf8          1.07
t/00-report.t .................................... ok
t/00compile.t .................................... ok
t/HashBase.t ..................................... ok
t/Legacy/00test_harness_check.t .................. ok
t/Legacy/01-basic.t .............................. ok
t/Legacy/478-cmp_ok_hash.t ....................... ok
t/Legacy/auto.t .................................. ok
t/Legacy/bad_plan.t .............................. ok
t/Legacy/bail_out.t .............................. ok
t/Legacy/BEGIN_require_ok.t ...................... ok
t/Legacy/BEGIN_use_ok.t .......................... ok
t/Legacy/buffer.t ................................ ok
t/Legacy/Bugs/600.t .............................. ok
t/Legacy/Bugs/629.t .............................. ok
t/Legacy/Builder/Builder.t ....................... ok
t/Legacy/Builder/carp.t .......................... ok
t/Legacy/Builder/create.t ........................ ok
t/Legacy/Builder/current_test.t .................. ok
t/Legacy/Builder/current_test_without_plan.t ..... ok
t/Legacy/Builder/details.t ....................... ok
t/Legacy/Builder/done_testing.t .................. ok
t/Legacy/Builder/done_testing_double.t ........... ok
t/Legacy/Builder/done_testing_plan_mismatch.t .... ok
t/Legacy/Builder/done_testing_with_no_plan.t ..... ok
t/Legacy/Builder/done_testing_with_number.t ...... ok
t/Legacy/Builder/done_testing_with_plan.t ........ ok
t/Legacy/Builder/fork_with_new_stdout.t .......... ok
t/Legacy/Builder/has_plan.t ...................... ok
t/Legacy/Builder/has_plan2.t ..................... ok
t/Legacy/Builder/is_fh.t ......................... ok
t/Legacy/Builder/is_passing.t .................... ok
t/Legacy/Builder/maybe_regex.t ................... ok
t/Legacy/Builder/no_diag.t ....................... ok
t/Legacy/Builder/no_ending.t ..................... ok
t/Legacy/Builder/no_header.t ..................... ok
t/Legacy/Builder/no_plan_at_all.t ................ ok
t/Legacy/Builder/ok_obj.t ........................ ok
t/Legacy/Builder/output.t ........................ ok
t/Legacy/Builder/reset.t ......................... ok
t/Legacy/Builder/reset_outputs.t ................. ok
t/Legacy/Builder/try.t ........................... ok
t/Legacy/c_flag.t ................................ ok
t/Legacy/capture.t ............................... ok
t/Legacy/check_tests.t ........................... ok
t/Legacy/circular_data.t ......................... ok
t/Legacy/cmp_ok.t ................................ ok
t/Legacy/depth.t ................................. ok
t/Legacy/diag.t .................................. ok
t/Legacy/died.t .................................. ok
t/Legacy/dont_overwrite_die_handler.t ............ ok
t/Legacy/eq_set.t ................................ ok
t/Legacy/exit.t .................................. ok
t/Legacy/explain.t ............................... ok
t/Legacy/explain_err_vars.t ...................... ok
t/Legacy/extra.t ................................. ok
t/Legacy/extra_one.t ............................. ok
t/Legacy/fail-like.t ............................. ok
t/Legacy/fail-more.t ............................. ok
t/Legacy/fail.t .................................. ok
t/Legacy/fail_one.t .............................. ok
t/Legacy/filehandles.t ........................... ok
t/Legacy/fork.t .................................. ok
t/Legacy/harness_active.t ........................ ok
t/Legacy/import.t ................................ ok
t/Legacy/is_deeply_dne_bug.t ..................... ok
t/Legacy/is_deeply_fail.t ........................ ok
t/Legacy/is_deeply_with_threads.t ................ skipped: many perls have broken threads.  Enable with AUTHOR_TESTING.
t/Legacy/missing.t ............................... ok
t/Legacy/More.t .................................. ok
t/Legacy/new_ok.t ................................ ok
t/Legacy/no_log_results.t ........................ ok
t/Legacy/no_plan.t ............................... ok
t/Legacy/no_tests.t .............................. ok
t/Legacy/note.t .................................. ok
t/Legacy/overload.t .............................. ok
t/Legacy/overload_threads.t ...................... ok
t/Legacy/plan.t .................................. ok
t/Legacy/plan_bad.t .............................. ok
t/Legacy/plan_is_noplan.t ........................ ok
t/Legacy/plan_no_plan.t .......................... ok
t/Legacy/plan_shouldnt_import.t .................. ok
t/Legacy/plan_skip_all.t ......................... skipped: Just testing plan & skip_all
t/Legacy/Regression/637.t ........................ skipped: many perls have broken threads.  Enable with AUTHOR_TESTING.
t/Legacy/Regression/683_thread_todo.t ............ ok
t/Legacy/Regression/6_cmp_ok.t ................... ok
t/Legacy/Regression/736_use_ok.t ................. ok
t/Legacy/Regression/789-read-only.t .............. skipped: AUTHOR_TESTING not enabled
t/Legacy/Regression/870-experimental-warnings.t .. skipped: Only testing on 5.18+
t/Legacy/Regression/is_capture.t ................. ok
t/Legacy/require_ok.t ............................ ok
t/Legacy/run_test.t .............................. ok
t/Legacy/simple.t ................................ ok
t/Legacy/Simple/load.t ........................... ok
t/Legacy/skip.t .................................. ok
t/Legacy/skipall.t ............................... ok
t/Legacy/strays.t ................................ skipped: not completed
t/Legacy/subtest/args.t .......................... ok
t/Legacy/subtest/bail_out.t ...................... ok
t/Legacy/subtest/basic.t ......................... ok
t/Legacy/subtest/callback.t ...................... ok
t/Legacy/subtest/die.t ........................... ok
t/Legacy/subtest/do.t ............................ ok
t/Legacy/subtest/events.t ........................ ok
t/Legacy/subtest/fork.t .......................... ok
t/Legacy/subtest/implicit_done.t ................. ok
t/Legacy/subtest/line_numbers.t .................. ok
t/Legacy/subtest/plan.t .......................... ok
t/Legacy/subtest/predicate.t ..................... ok
t/Legacy/subtest/singleton.t ..................... ok
t/Legacy/subtest/threads.t ....................... ok
t/Legacy/subtest/todo.t .......................... ok
t/Legacy/subtest/wstat.t ......................... ok
t/Legacy/tbm_doesnt_set_exported_to.t ............ ok
t/Legacy/Test2/Subtest.t ......................... ok
t/Legacy/Tester/tbt_01basic.t .................... ok
t/Legacy/Tester/tbt_02fhrestore.t ................ ok
t/Legacy/Tester/tbt_03die.t ...................... ok
t/Legacy/Tester/tbt_04line_num.t ................. ok
t/Legacy/Tester/tbt_05faildiag.t ................. ok
t/Legacy/Tester/tbt_06errormess.t ................ ok
t/Legacy/Tester/tbt_07args.t ..................... ok
t/Legacy/Tester/tbt_08subtest.t .................. ok
t/Legacy/Tester/tbt_09do.t ....................... ok
t/Legacy/thread_taint.t .......................... ok
t/Legacy/threads.t ............................... ok
t/Legacy/todo.t .................................. ok
t/Legacy/undef.t ................................. ok
t/Legacy/use_ok.t ................................ ok
t/Legacy/useing.t ................................ ok
t/Legacy/utf8.t .................................. ok
t/Legacy/versions.t .............................. ok
t/Legacy_And_Test2/builder_loaded_late.t ......... ok
t/Legacy_And_Test2/diag_event_on_ok.t ............ ok
t/Legacy_And_Test2/hidden_warnings.t ............. ok
t/Legacy_And_Test2/preload_diag_note.t ........... ok
t/Legacy_And_Test2/thread_init_warning.t ......... ok
t/regression/642_persistent_end.t ................ ok
t/regression/662-tbt-no-plan.t ................... ok
t/regression/684-nested_todo_diag.t .............. ok
t/regression/694_note_diag_return_values.t ....... ok
t/regression/696-intercept_skip_all.t ............ ok
t/regression/721-nested-streamed-subtest.t ....... ok
t/regression/757-reset_in_subtest.t .............. ok
t/regression/812-todo.t .......................... ok
t/regression/817-subtest-todo.t .................. ok
t/regression/862-intercept_tb_todo.t ............. ok
t/regression/buffered_subtest_plan_buffered.t .... ok
t/regression/builder_does_not_init.t ............. ok
t/regression/errors_facet.t ...................... ok
t/regression/fork_first.t ........................ ok
t/regression/inherit_trace.t ..................... ok
t/regression/no_name_in_subtest.t ................ ok
t/regression/todo_and_facets.t ................... ok
t/Test2/acceptance/try_it_done_testing.t ......... ok
t/Test2/acceptance/try_it_fork.t ................. ok
t/Test2/acceptance/try_it_no_plan.t .............. ok
t/Test2/acceptance/try_it_plan.t ................. ok
t/Test2/acceptance/try_it_skip.t ................. skipped: testing skip all
t/Test2/acceptance/try_it_threads.t .............. ok
t/Test2/acceptance/try_it_todo.t ................. ok
t/Test2/behavior/disable_ipc_a.t ................. ok
t/Test2/behavior/disable_ipc_b.t ................. ok
t/Test2/behavior/disable_ipc_c.t ................. ok
t/Test2/behavior/disable_ipc_d.t ................. ok
t/Test2/behavior/err_var.t ....................... ok
t/Test2/behavior/Formatter.t ..................... ok
t/Test2/behavior/init_croak.t .................... ok
t/Test2/behavior/intercept.t ..................... ok
t/Test2/behavior/ipc_wait_timeout.t .............. ok
t/Test2/behavior/nested_context_exception.t ...... ok
t/Test2/behavior/no_load_api.t ................... ok
t/Test2/behavior/run_subtest_inherit.t ........... ok
t/Test2/behavior/special_names.t ................. ok
t/Test2/behavior/subtest_bailout.t ............... ok
t/Test2/behavior/Subtest_buffer_formatter.t ...... ok
t/Test2/behavior/Subtest_callback.t .............. ok
t/Test2/behavior/Subtest_events.t ................ ok
t/Test2/behavior/Subtest_plan.t .................. ok
t/Test2/behavior/Subtest_todo.t .................. ok
t/Test2/behavior/Taint.t ......................... ok
t/Test2/behavior/trace_signature.t ............... ok
t/Test2/behavior/uuid.t .......................... ok
t/Test2/legacy/TAP.t ............................. ok
t/Test2/modules/API.t ............................ ok
t/Test2/modules/API/Breakage.t ................... ok
t/Test2/modules/API/Context.t .................... ok
t/Test2/modules/API/Instance.t ................... ok
t/Test2/modules/API/InterceptResult.t ............ ok
t/Test2/modules/API/InterceptResult/Event.t ...... ok
t/Test2/modules/API/InterceptResult/Squasher.t ... ok
t/Test2/modules/API/Stack.t ...................... ok
t/Test2/modules/Event.t .......................... ok
t/Test2/modules/Event/Bail.t ..................... ok
t/Test2/modules/Event/Diag.t ..................... ok
t/Test2/modules/Event/Encoding.t ................. ok
t/Test2/modules/Event/Exception.t ................ ok
t/Test2/modules/Event/Fail.t ..................... ok
t/Test2/modules/Event/Generic.t .................. ok
t/Test2/modules/Event/Note.t ..................... ok
t/Test2/modules/Event/Ok.t ....................... ok
t/Test2/modules/Event/Pass.t ..................... ok
t/Test2/modules/Event/Plan.t ..................... ok
t/Test2/modules/Event/Skip.t ..................... ok
t/Test2/modules/Event/Subtest.t .................. ok
t/Test2/modules/Event/TAP/Version.t .............. ok
t/Test2/modules/Event/V2.t ....................... ok
t/Test2/modules/Event/Waiting.t .................. ok
t/Test2/modules/EventFacet.t ..................... ok
t/Test2/modules/EventFacet/About.t ............... ok
t/Test2/modules/EventFacet/Amnesty.t ............. ok
t/Test2/modules/EventFacet/Assert.t .............. ok
t/Test2/modules/EventFacet/Control.t ............. ok
t/Test2/modules/EventFacet/Error.t ............... ok
t/Test2/modules/EventFacet/Info.t ................ ok
t/Test2/modules/EventFacet/Meta.t ................ ok
t/Test2/modules/EventFacet/Parent.t .............. ok
t/Test2/modules/EventFacet/Plan.t ................ ok
t/Test2/modules/EventFacet/Trace.t ............... ok
t/Test2/modules/Formatter/TAP.t .................. ok
t/Test2/modules/Hub.t ............................ ok
t/Test2/modules/Hub/Interceptor.t ................ ok
t/Test2/modules/Hub/Interceptor/Terminator.t ..... ok
t/Test2/modules/Hub/Subtest.t .................... ok
t/Test2/modules/IPC.t ............................ ok
t/Test2/modules/IPC/Driver.t ..................... ok
t/Test2/modules/IPC/Driver/Files.t ............... ok
t/Test2/modules/Tools/Tiny.t ..................... ok
t/Test2/modules/Util.t ........................... ok
t/Test2/modules/Util/ExternalMeta.t .............. ok
t/Test2/modules/Util/Facets2Legacy.t ............. ok
t/Test2/modules/Util/Trace.t ..................... ok
t/Test2/regression/693_ipc_ordering.t ............ ok
t/Test2/regression/746-forking-subtest.t ......... ok
t/Test2/regression/gh_16.t ....................... skipped: Crazy test, only run on 5.20+, or when AUTHOR_TESTING is set
t/Test2/regression/ipc_files_abort_exit.t ........ skipped: Set AUTHOR_TESTING to run this test
t/zzz-check-breaks.t ............................. 1/? # You have the following modules installed, which are not compatible with the latest Test::More:
# Installed version (0.31) of Test::Exception is in range '<= 0.42'
#
# You should now update these modules!
# You should also see Test2::Transition!
t/zzz-check-breaks.t ............................. ok
All tests successful.
Files=236, Tests=2666, 19 wallclock secs ( 0.66 usr  0.31 sys + 10.25 cusr  2.11 csys = 13.33 CPU)
Result: PASS
  EXODIST/Test-Simple-1.302183.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/Test-Simple-1.302183-FFuls2/blib/arch /root/.cpan/build/Test-Simple-1.302183-FFuls2/blib/lib to PERL5LIB for 'install'
Manifying 36 pod documents
Manifying 34 pod documents
Manifying 1 pod document
Installing /usr/local/share/perl5/ok.pm
Installing /usr/local/share/perl5/Test2.pm
Installing /usr/local/share/perl5/Test/Simple.pm
Installing /usr/local/share/perl5/Test/Tester.pm
Installing /usr/local/share/perl5/Test/Tutorial.pod
Installing /usr/local/share/perl5/Test/More.pm
Installing /usr/local/share/perl5/Test/Builder.pm
Installing /usr/local/share/perl5/Test/Tester/Capture.pm
Installing /usr/local/share/perl5/Test/Tester/CaptureRunner.pm
Installing /usr/local/share/perl5/Test/Tester/Delegate.pm
Installing /usr/local/share/perl5/Test/use/ok.pm
Installing /usr/local/share/perl5/Test/Builder/Formatter.pm
Installing /usr/local/share/perl5/Test/Builder/Tester.pm
Installing /usr/local/share/perl5/Test/Builder/Module.pm
Installing /usr/local/share/perl5/Test/Builder/TodoDiag.pm
Installing /usr/local/share/perl5/Test/Builder/Tester/Color.pm
Installing /usr/local/share/perl5/Test/Builder/IO/Scalar.pm
Installing /usr/local/share/perl5/Test2/Hub.pm
Installing /usr/local/share/perl5/Test2/Formatter.pm
Installing /usr/local/share/perl5/Test2/EventFacet.pm
Installing /usr/local/share/perl5/Test2/API.pm
Installing /usr/local/share/perl5/Test2/IPC.pm
Installing /usr/local/share/perl5/Test2/Event.pm
Installing /usr/local/share/perl5/Test2/Util.pm
Installing /usr/local/share/perl5/Test2/Transition.pod
Installing /usr/local/share/perl5/Test2/Tools/Tiny.pm
Installing /usr/local/share/perl5/Test2/Event/Ok.pm
Installing /usr/local/share/perl5/Test2/Event/Fail.pm
Installing /usr/local/share/perl5/Test2/Event/Encoding.pm
Installing /usr/local/share/perl5/Test2/Event/Plan.pm
Installing /usr/local/share/perl5/Test2/Event/Waiting.pm
Installing /usr/local/share/perl5/Test2/Event/Subtest.pm
Installing /usr/local/share/perl5/Test2/Event/Exception.pm
Installing /usr/local/share/perl5/Test2/Event/Note.pm
Installing /usr/local/share/perl5/Test2/Event/Bail.pm
Installing /usr/local/share/perl5/Test2/Event/Diag.pm
Installing /usr/local/share/perl5/Test2/Event/Skip.pm
Installing /usr/local/share/perl5/Test2/Event/V2.pm
Installing /usr/local/share/perl5/Test2/Event/Pass.pm
Installing /usr/local/share/perl5/Test2/Event/Generic.pm
Installing /usr/local/share/perl5/Test2/Event/TAP/Version.pm
Installing /usr/local/share/perl5/Test2/Util/Trace.pm
Installing /usr/local/share/perl5/Test2/Util/HashBase.pm
Installing /usr/local/share/perl5/Test2/Util/ExternalMeta.pm
Installing /usr/local/share/perl5/Test2/Util/Facets2Legacy.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Hub.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Trace.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Error.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Plan.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Amnesty.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Render.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Meta.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Info.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Parent.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Assert.pm
Installing /usr/local/share/perl5/Test2/EventFacet/About.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Control.pm
Installing /usr/local/share/perl5/Test2/EventFacet/Info/Table.pm
Installing /usr/local/share/perl5/Test2/Hub/Subtest.pm
Installing /usr/local/share/perl5/Test2/Hub/Interceptor.pm
Installing /usr/local/share/perl5/Test2/Hub/Interceptor/Terminator.pm
Installing /usr/local/share/perl5/Test2/IPC/Driver.pm
Installing /usr/local/share/perl5/Test2/IPC/Driver/Files.pm
Installing /usr/local/share/perl5/Test2/Formatter/TAP.pm
Installing /usr/local/share/perl5/Test2/API/Context.pm
Installing /usr/local/share/perl5/Test2/API/Breakage.pm
Installing /usr/local/share/perl5/Test2/API/Instance.pm
Installing /usr/local/share/perl5/Test2/API/Stack.pm
Installing /usr/local/share/perl5/Test2/API/InterceptResult.pm
Installing /usr/local/share/perl5/Test2/API/InterceptResult/Hub.pm
Installing /usr/local/share/perl5/Test2/API/InterceptResult/Event.pm
Installing /usr/local/share/perl5/Test2/API/InterceptResult/Squasher.pm
Installing /usr/local/share/perl5/Test2/API/InterceptResult/Facet.pm
Installing /usr/local/share/man/man3/Test2::Event::Skip.3pm
Installing /usr/local/share/man/man3/Test2::IPC::Driver::Files.3pm
Installing /usr/local/share/man/man3/Test2::Util.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Assert.3pm
Installing /usr/local/share/man/man3/Test2::Util::Trace.3pm
Installing /usr/local/share/man/man3/Test::Builder.3pm
Installing /usr/local/share/man/man3/Test2::Hub.3pm
Installing /usr/local/share/man/man3/Test2::Event::Ok.3pm
Installing /usr/local/share/man/man3/Test2::Util::Facets2Legacy.3pm
Installing /usr/local/share/man/man3/Test2::Event::TAP::Version.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Control.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Tiny.3pm
Installing /usr/local/share/man/man3/Test::Simple.3pm
Installing /usr/local/share/man/man3/Test2::Util::HashBase.3pm
Installing /usr/local/share/man/man3/Test::Builder::IO::Scalar.3pm
Installing /usr/local/share/man/man3/Test2::Event::Generic.3pm
Installing /usr/local/share/man/man3/Test2::Event::Encoding.3pm
Installing /usr/local/share/man/man3/Test2::Event::Pass.3pm
Installing /usr/local/share/man/man3/Test2::API::InterceptResult::Event.3pm
Installing /usr/local/share/man/man3/Test::use::ok.3pm
Installing /usr/local/share/man/man3/Test2::Hub::Interceptor.3pm
Installing /usr/local/share/man/man3/Test2::Event::Fail.3pm
Installing /usr/local/share/man/man3/Test2::Formatter::TAP.3pm
Installing /usr/local/share/man/man3/Test2::Util::ExternalMeta.3pm
Installing /usr/local/share/man/man3/Test2::Formatter.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Render.3pm
Installing /usr/local/share/man/man3/Test2::Hub::Interceptor::Terminator.3pm
Installing /usr/local/share/man/man3/Test2::IPC.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Error.3pm
Installing /usr/local/share/man/man3/Test2::Event::V2.3pm
Installing /usr/local/share/man/man3/Test::Tutorial.3pm
Installing /usr/local/share/man/man3/Test2::API::Breakage.3pm
Installing /usr/local/share/man/man3/Test2::API::InterceptResult.3pm
Installing /usr/local/share/man/man3/Test::More.3pm
Installing /usr/local/share/man/man3/Test::Builder::Tester.3pm
Installing /usr/local/share/man/man3/Test::Tester.3pm
Installing /usr/local/share/man/man3/Test2::Event::Exception.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Info.3pm
Installing /usr/local/share/man/man3/Test::Tester::CaptureRunner.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Trace.3pm
Installing /usr/local/share/man/man3/Test2::Event::Diag.3pm
Installing /usr/local/share/man/man3/Test2::Hub::Subtest.3pm
Installing /usr/local/share/man/man3/Test2::Transition.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Meta.3pm
Installing /usr/local/share/man/man3/Test2::API::Context.3pm
Installing /usr/local/share/man/man3/Test2::IPC::Driver.3pm
Installing /usr/local/share/man/man3/Test2::Event::Subtest.3pm
Installing /usr/local/share/man/man3/Test2::API::Instance.3pm
Installing /usr/local/share/man/man3/Test2.3pm
Installing /usr/local/share/man/man3/Test2::API::InterceptResult::Hub.3pm
Installing /usr/local/share/man/man3/Test::Builder::TodoDiag.3pm
Installing /usr/local/share/man/man3/Test2::Event.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::About.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Hub.3pm
Installing /usr/local/share/man/man3/Test::Builder::Tester::Color.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Parent.3pm
Installing /usr/local/share/man/man3/Test2::Event::Waiting.3pm
Installing /usr/local/share/man/man3/Test2::API.3pm
Installing /usr/local/share/man/man3/Test2::API::InterceptResult::Squasher.3pm
Installing /usr/local/share/man/man3/Test2::Event::Plan.3pm
Installing /usr/local/share/man/man3/ok.3pm
Installing /usr/local/share/man/man3/Test2::API::Stack.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Info::Table.3pm
Installing /usr/local/share/man/man3/Test::Tester::Capture.3pm
Installing /usr/local/share/man/man3/Test2::Event::Note.3pm
Installing /usr/local/share/man/man3/Test::Builder::Formatter.3pm
Installing /usr/local/share/man/man3/Test::Builder::Module.3pm
Installing /usr/local/share/man/man3/Test2::Event::Bail.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Plan.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet.3pm
Installing /usr/local/share/man/man3/Test2::EventFacet::Amnesty.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  EXODIST/Test-Simple-1.302183.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'File::chdir'
Running make for D/DA/DAGOLDEN/File-chdir-0.1010.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/D/DA/DAGOLDEN/File-chdir-0.1010.tar.gz
Checksum for /root/.cpan/sources/authors/id/D/DA/DAGOLDEN/File-chdir-0.1010.tar.gz ok
File-chdir-0.1010/
File-chdir-0.1010/Changes
File-chdir-0.1010/CONTRIBUTING.mkdn
File-chdir-0.1010/cpanfile
File-chdir-0.1010/dist.ini
File-chdir-0.1010/examples/
File-chdir-0.1010/lib/
File-chdir-0.1010/LICENSE
File-chdir-0.1010/Makefile.PL
File-chdir-0.1010/MANIFEST
File-chdir-0.1010/META.json
File-chdir-0.1010/META.yml
File-chdir-0.1010/perlcritic.rc
File-chdir-0.1010/README
File-chdir-0.1010/t/
File-chdir-0.1010/xt/
File-chdir-0.1010/xt/author/
File-chdir-0.1010/xt/release/
File-chdir-0.1010/xt/release/distmeta.t
File-chdir-0.1010/xt/release/minimum-version.t
File-chdir-0.1010/xt/release/pod-coverage.t
File-chdir-0.1010/xt/release/pod-syntax.t
File-chdir-0.1010/xt/release/portability.t
File-chdir-0.1010/xt/release/test-version.t
File-chdir-0.1010/xt/author/00-compile.t
File-chdir-0.1010/xt/author/critic.t
File-chdir-0.1010/xt/author/pod-spell.t
File-chdir-0.1010/t/00-report-prereqs.dd
File-chdir-0.1010/t/00-report-prereqs.t
File-chdir-0.1010/t/array.t
File-chdir-0.1010/t/chdir.t
File-chdir-0.1010/t/delete-array.t
File-chdir-0.1010/t/lib/
File-chdir-0.1010/t/nested.t
File-chdir-0.1010/t/newline.t
File-chdir-0.1010/t/var.t
File-chdir-0.1010/t/lib/dummy.txt
File-chdir-0.1010/lib/File/
File-chdir-0.1010/lib/File/chdir.pm
File-chdir-0.1010/examples/chdir-example.pl

  CPAN.pm: Building D/DA/DAGOLDEN/File-chdir-0.1010.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for File::chdir
Writing MYMETA.yml and MYMETA.json
cp lib/File/chdir.pm blib/lib/File/chdir.pm
Manifying 1 pod document
  DAGOLDEN/File-chdir-0.1010.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00-report-prereqs.t .. #
# Versions for all modules listed in MYMETA.json (including optional ones):
#
# === Configure Requires ===
#
#     Module              Want Have
#     ------------------- ---- ----
#     ExtUtils::MakeMaker 6.17 7.58
#
# === Build Requires ===
#
#     Module              Want Have
#     ------------------- ---- ----
#     ExtUtils::MakeMaker  any 7.58
#
# === Test Requires ===
#
#     Module              Want     Have
#     ------------------- ---- --------
#     ExtUtils::MakeMaker  any     7.58
#     File::Spec           any     3.30
#     Test::More           any 1.302183
#     warnings             any     1.06
#
# === Test Recommends ===
#
#     Module         Want     Have
#     ---------- -------- --------
#     CPAN::Meta 2.120900 2.143240
#
# === Runtime Requires ===
#
#     Module                Want Have
#     --------------------- ---- ----
#     Carp                   any 1.11
#     Cwd                   3.16 3.30
#     Exporter               any 5.63
#     File::Spec::Functions 3.27 3.30
#     strict                 any 1.04
#     vars                   any 1.01
#
t/00-report-prereqs.t .. ok
t/array.t .............. ok
t/chdir.t .............. ok
t/delete-array.t ....... ok
t/nested.t ............. ok
t/newline.t ............ ok
t/var.t ................ ok
All tests successful.
Files=7, Tests=94,  1 wallclock secs ( 0.02 usr  0.01 sys +  0.33 cusr  0.04 csys =  0.40 CPU)
Result: PASS
  DAGOLDEN/File-chdir-0.1010.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/File-chdir-0.1010-8t4bgD/blib/arch /root/.cpan/build/File-chdir-0.1010-8t4bgD/blib/lib to PERL5LIB for 'install'
Manifying 1 pod document
Installing /usr/local/share/perl5/File/chdir.pm
Installing /usr/local/share/man/man3/File::chdir.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  DAGOLDEN/File-chdir-0.1010.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'List::Util'
Running make for P/PE/PEVANS/Scalar-List-Utils-1.55.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/P/PE/PEVANS/Scalar-List-Utils-1.55.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/P/PE/PEVANS/CHECKSUMS
Checksum for /root/.cpan/sources/authors/id/P/PE/PEVANS/Scalar-List-Utils-1.55.tar.gz ok
Scalar-List-Utils-1.55/
Scalar-List-Utils-1.55/lib/
Scalar-List-Utils-1.55/lib/Scalar/
Scalar-List-Utils-1.55/lib/Scalar/Util.pm
Scalar-List-Utils-1.55/lib/Sub/
Scalar-List-Utils-1.55/lib/Sub/Util.pm
Scalar-List-Utils-1.55/lib/List/
Scalar-List-Utils-1.55/lib/List/Util.pm
Scalar-List-Utils-1.55/lib/List/Util/
Scalar-List-Utils-1.55/lib/List/Util/XS.pm
Scalar-List-Utils-1.55/MANIFEST
Scalar-List-Utils-1.55/META.json
Scalar-List-Utils-1.55/ListUtil.xs
Scalar-List-Utils-1.55/t/
Scalar-List-Utils-1.55/t/minstr.t
Scalar-List-Utils-1.55/t/refaddr.t
Scalar-List-Utils-1.55/t/shuffle.t
Scalar-List-Utils-1.55/t/uniqnum.t
Scalar-List-Utils-1.55/t/reductions.t
Scalar-List-Utils-1.55/t/prototype.t
Scalar-List-Utils-1.55/t/min.t
Scalar-List-Utils-1.55/t/reftype.t
Scalar-List-Utils-1.55/t/sum0.t
Scalar-List-Utils-1.55/t/rt-96343.t
Scalar-List-Utils-1.55/t/readonly.t
Scalar-List-Utils-1.55/t/maxstr.t
Scalar-List-Utils-1.55/t/weak.t
Scalar-List-Utils-1.55/t/dualvar.t
Scalar-List-Utils-1.55/t/reduce.t
Scalar-List-Utils-1.55/t/blessed.t
Scalar-List-Utils-1.55/t/head-tail.t
Scalar-List-Utils-1.55/t/sample.t
Scalar-List-Utils-1.55/t/openhan.t
Scalar-List-Utils-1.55/t/subname.t
Scalar-List-Utils-1.55/t/any-all.t
Scalar-List-Utils-1.55/t/product.t
Scalar-List-Utils-1.55/t/isvstring.t
Scalar-List-Utils-1.55/t/00version.t
Scalar-List-Utils-1.55/t/uniq.t
Scalar-List-Utils-1.55/t/sum.t
Scalar-List-Utils-1.55/t/scalarutil-proto.t
Scalar-List-Utils-1.55/t/getmagic-once.t
Scalar-List-Utils-1.55/t/tainted.t
Scalar-List-Utils-1.55/t/pair.t
Scalar-List-Utils-1.55/t/max.t
Scalar-List-Utils-1.55/t/exotic_names.t
Scalar-List-Utils-1.55/t/first.t
Scalar-List-Utils-1.55/t/stack-corruption.t
Scalar-List-Utils-1.55/t/lln.t
Scalar-List-Utils-1.55/multicall.h
Scalar-List-Utils-1.55/Changes
Scalar-List-Utils-1.55/Makefile.PL
Scalar-List-Utils-1.55/README
Scalar-List-Utils-1.55/META.yml
Scalar-List-Utils-1.55/ppport.h

  CPAN.pm: Building P/PE/PEVANS/Scalar-List-Utils-1.55.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for List::Util
Writing MYMETA.yml and MYMETA.json
cp lib/List/Util/XS.pm blib/lib/List/Util/XS.pm
cp lib/Sub/Util.pm blib/lib/Sub/Util.pm
cp lib/List/Util.pm blib/lib/List/Util.pm
cp lib/Scalar/Util.pm blib/lib/Scalar/Util.pm
Running Mkbootstrap for Util ()
chmod 644 "Util.bs"
"/usr/bin/perl" -MExtUtils::Command::MM -e 'cp_nonempty' -- Util.bs blib/arch/auto/List/Util/Util.bs 644
"/usr/bin/perl" "/usr/local/share/perl5/ExtUtils/xsubpp"  -typemap '/usr/share/perl5/ExtUtils/typemap'  ListUtil.xs > ListUtil.xsc
mv ListUtil.xsc ListUtil.c
gcc -c   -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic   -DVERSION=\"1.55\" -DXS_VERSION=\"1.55\" -fPIC "-I/usr/lib64/perl5/CORE"  -DPERL_EXT -DUSE_PPPORT_H ListUtil.c
ListUtil.xs: In function ‘XS_List__Util_uniq’:
ListUtil.xs:1397: warning: value computed is not used
ListUtil.xs: In function ‘XS_List__Util_uniqnum’:
ListUtil.xs:1553: warning: value computed is not used
ListUtil.xs: In function ‘XS_Sub__Util_set_subname’:
ListUtil.xs:1944: warning: suggest parentheses around arithmetic in operand of ‘|’
ListUtil.c: In function ‘XS_List__Util_reduce’:
ListUtil.xs:530: warning: ‘retvals’ may be used uninitialized in this function
ListUtil.xs:530: note: ‘retvals’ was declared here
rm -f blib/arch/auto/List/Util/Util.so
gcc  -shared -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic  ListUtil.o  -o blib/arch/auto/List/Util/Util.so  \
              \

chmod 755 blib/arch/auto/List/Util/Util.so
Manifying 4 pod documents
  PEVANS/Scalar-List-Utils-1.55.tar.gz
  /usr/bin/make -- OK
Running make test
"/usr/bin/perl" -MExtUtils::Command::MM -e 'cp_nonempty' -- Util.bs blib/arch/auto/List/Util/Util.bs 644
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00version.t ......... ok
t/any-all.t ........... ok
t/blessed.t ........... ok
t/dualvar.t ........... ok
t/exotic_names.t ...... ok
t/first.t ............. ok
t/getmagic-once.t ..... ok
t/head-tail.t ......... ok
t/isvstring.t ......... ok
t/lln.t ............... ok
t/max.t ............... ok
t/maxstr.t ............ ok
t/min.t ............... ok
t/minstr.t ............ ok
t/openhan.t ........... ok
t/pair.t .............. ok
t/product.t ........... ok
t/prototype.t ......... ok
t/readonly.t .......... ok
t/reduce.t ............ ok
t/reductions.t ........ ok
t/refaddr.t ........... ok
t/reftype.t ........... ok
t/rt-96343.t .......... ok
t/sample.t ............ ok
t/scalarutil-proto.t .. ok
t/shuffle.t ........... ok
t/stack-corruption.t .. ok
t/subname.t ........... ok
t/sum.t ............... ok
t/sum0.t .............. ok
t/tainted.t ........... ok
t/uniq.t .............. ok
t/uniqnum.t ........... ok
t/weak.t .............. ok
All tests successful.
Files=35, Tests=2124,  2 wallclock secs ( 0.20 usr  0.05 sys +  1.60 cusr  0.21 csys =  2.06 CPU)
Result: PASS
  PEVANS/Scalar-List-Utils-1.55.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/Scalar-List-Utils-1.55-x2Ru2r/blib/arch /root/.cpan/build/Scalar-List-Utils-1.55-x2Ru2r/blib/lib to PERL5LIB for 'install'
"/usr/bin/perl" -MExtUtils::Command::MM -e 'cp_nonempty' -- Util.bs blib/arch/auto/List/Util/Util.bs 644
Manifying 4 pod documents
Files found in blib/arch: installing files in blib/lib into architecture dependent library tree
Installing /usr/local/lib64/perl5/auto/List/Util/Util.so
Installing /usr/local/lib64/perl5/Sub/Util.pm
Installing /usr/local/lib64/perl5/List/Util.pm
Installing /usr/local/lib64/perl5/List/Util/XS.pm
Installing /usr/local/lib64/perl5/Scalar/Util.pm
Installing /usr/local/share/man/man3/Scalar::Util.3pm
Installing /usr/local/share/man/man3/List::Util::XS.3pm
Installing /usr/local/share/man/man3/Sub::Util.3pm
Installing /usr/local/share/man/man3/List::Util.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  PEVANS/Scalar-List-Utils-1.55.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'Test2::V0'
Running make for E/EX/EXODIST/Test2-Suite-0.000139.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/E/EX/EXODIST/Test2-Suite-0.000139.tar.gz
Checksum for /root/.cpan/sources/authors/id/E/EX/EXODIST/Test2-Suite-0.000139.tar.gz ok
Test2-Suite-0.000139
Test2-Suite-0.000139/README
Test2-Suite-0.000139/LICENSE
Test2-Suite-0.000139/Changes
Test2-Suite-0.000139/MANIFEST
Test2-Suite-0.000139/cpanfile
Test2-Suite-0.000139/META.yml
Test2-Suite-0.000139/META.json
Test2-Suite-0.000139/README.md
Test2-Suite-0.000139/perltidyrc
Test2-Suite-0.000139/Makefile.PL
Test2-Suite-0.000139/appveyor.yml
Test2-Suite-0.000139/t
Test2-Suite-0.000139/t/00-report.t
Test2-Suite-0.000139/t/modules
Test2-Suite-0.000139/t/modules/V0.t
Test2-Suite-0.000139/lib/Test2
Test2-Suite-0.000139/lib/Test2/V0.pm
Test2-Suite-0.000139/t/load_manual.t
Test2-Suite-0.000139/t/modules/Mock.t
Test2-Suite-0.000139/t/modules/Todo.t
Test2-Suite-0.000139/lib/Test2/Todo.pm
Test2-Suite-0.000139/lib/Test2/Mock.pm
Test2-Suite-0.000139/t/modules/Suite.t
Test2-Suite-0.000139/t/modules/Tools.t
Test2-Suite-0.000139/t/acceptance
Test2-Suite-0.000139/t/acceptance/OO.t
Test2-Suite-0.000139/lib/Test2/Suite.pm
Test2-Suite-0.000139/lib/Test2/Tools.pm
Test2-Suite-0.000139/t/modules/Plugin.t
Test2-Suite-0.000139/t/modules/Bundle.t
Test2-Suite-0.000139/lib/Test2/Plugin.pm
Test2-Suite-0.000139/lib/Test2/Manual.pm
Test2-Suite-0.000139/lib/Test2/Bundle.pm
Test2-Suite-0.000139/t/behavior
Test2-Suite-0.000139/t/behavior/simple.t
Test2-Suite-0.000139/t/modules/Compare.t
Test2-Suite-0.000139/t/modules/Require.t
Test2-Suite-0.000139/t/acceptance/skip.t
Test2-Suite-0.000139/t/acceptance/spec.t
Test2-Suite-0.000139/lib/Test2/Require.pm
Test2-Suite-0.000139/lib/Test2/Compare.pm
Test2-Suite-0.000139/t/behavior/Mocking.t
Test2-Suite-0.000139/t/modules/Workflow.t
Test2-Suite-0.000139/t/modules/Util
Test2-Suite-0.000139/t/modules/Util/Ref.t
Test2-Suite-0.000139/t/modules/Util/Sub.t
Test2-Suite-0.000139/t/acceptance/Tools.t
Test2-Suite-0.000139/lib/Test2/Workflow.pm
Test2-Suite-0.000139/lib/Test2/Util
Test2-Suite-0.000139/lib/Test2/Util/Sub.pm
Test2-Suite-0.000139/lib/Test2/Util/Ref.pm
Test2-Suite-0.000139/t/modules/Tools
Test2-Suite-0.000139/t/modules/Tools/Ref.t
Test2-Suite-0.000139/lib/Test2/Util/Term.pm
Test2-Suite-0.000139/lib/Test2/Tools
Test2-Suite-0.000139/lib/Test2/Tools/Ref.pm
Test2-Suite-0.000139/t/behavior/filtering.t
Test2-Suite-0.000139/t/modules/Util/Times.t
Test2-Suite-0.000139/t/modules/Util/Table.t
Test2-Suite-0.000139/t/modules/Util/Stash.t
Test2-Suite-0.000139/t/modules/Tools/Spec.t
Test2-Suite-0.000139/t/modules/Tools/Grab.t
Test2-Suite-0.000139/t/modules/Tools/Mock.t
Test2-Suite-0.000139/t/lib/MyTest
Test2-Suite-0.000139/t/lib/MyTest/Target.pm
Test2-Suite-0.000139/lib/Test2/Util/Table.pm
Test2-Suite-0.000139/lib/Test2/Util/Stash.pm
Test2-Suite-0.000139/lib/Test2/Util/Times.pm
Test2-Suite-0.000139/lib/Test2/Tools/Grab.pm
Test2-Suite-0.000139/lib/Test2/Tools/Spec.pm
Test2-Suite-0.000139/lib/Test2/Tools/Mock.pm
Test2-Suite-0.000139/t/regression
Test2-Suite-0.000139/t/regression/132-bool.t
Test2-Suite-0.000139/t/modules/Compare
Test2-Suite-0.000139/t/modules/Compare/Isa.t
Test2-Suite-0.000139/t/modules/Compare/Bag.t
Test2-Suite-0.000139/t/modules/Compare/Ref.t
Test2-Suite-0.000139/t/modules/Compare/Set.t
Test2-Suite-0.000139/t/modules/Tools/Event.t
Test2-Suite-0.000139/t/modules/Tools/Class.t
Test2-Suite-0.000139/t/modules/Tools/Basic.t
Test2-Suite-0.000139/t/modules/Tools/Defer.t
Test2-Suite-0.000139/t/modules/Bundle
Test2-Suite-0.000139/t/modules/Bundle/More.t
Test2-Suite-0.000139/t/modules/Plugin
Test2-Suite-0.000139/t/modules/Plugin/UTF8.t
Test2-Suite-0.000139/lib/Test2/Compare
Test2-Suite-0.000139/lib/Test2/Compare/Isa.pm
Test2-Suite-0.000139/lib/Test2/Compare/Bag.pm
Test2-Suite-0.000139/lib/Test2/Compare/Set.pm
Test2-Suite-0.000139/lib/Test2/Compare/Ref.pm
Test2-Suite-0.000139/lib/Test2/Tools/Defer.pm
Test2-Suite-0.000139/lib/Test2/Tools/Basic.pm
Test2-Suite-0.000139/lib/Test2/Tools/Class.pm
Test2-Suite-0.000139/lib/Test2/Tools/Event.pm
Test2-Suite-0.000139/lib/Test2/Bundle
Test2-Suite-0.000139/lib/Test2/Bundle/More.pm
Test2-Suite-0.000139/lib/Test2/Plugin
Test2-Suite-0.000139/lib/Test2/Plugin/UTF8.pm
Test2-Suite-0.000139/t/regression/utf8-mock.t
Test2-Suite-0.000139/t/behavior/async_trace.t
Test2-Suite-0.000139/t/modules/AsyncSubtest.t
Test2-Suite-0.000139/t/modules/Util/Grabber.t
Test2-Suite-0.000139/t/modules/Compare/Hash.t
Test2-Suite-0.000139/t/modules/Compare/Base.t
Test2-Suite-0.000139/t/modules/Compare/Bool.t
Test2-Suite-0.000139/t/modules/Compare/Meta.t
Test2-Suite-0.000139/t/modules/Tools/Tester.t
Test2-Suite-0.000139/t/modules/Tools/Target.t
Test2-Suite-0.000139/t/modules/Plugin/Times.t
Test2-Suite-0.000139/t/modules/Plugin/SRand.t
Test2-Suite-0.000139/t/modules/Require
Test2-Suite-0.000139/t/modules/Require/Perl.t
Test2-Suite-0.000139/t/modules/Require/Fork.t
Test2-Suite-0.000139/lib/Test2/AsyncSubtest.pm
Test2-Suite-0.000139/lib/Test2/Util/Grabber.pm
Test2-Suite-0.000139/lib/Test2/Compare/Base.pm
Test2-Suite-0.000139/lib/Test2/Compare/Bool.pm
Test2-Suite-0.000139/lib/Test2/Compare/Hash.pm
Test2-Suite-0.000139/lib/Test2/Compare/Meta.pm
Test2-Suite-0.000139/lib/Test2/Tools/Tester.pm
Test2-Suite-0.000139/lib/Test2/Tools/Target.pm
Test2-Suite-0.000139/lib/Test2/Plugin/SRand.pm
Test2-Suite-0.000139/lib/Test2/Plugin/Times.pm
Test2-Suite-0.000139/lib/Test2/Require
Test2-Suite-0.000139/lib/Test2/Require/Fork.pm
Test2-Suite-0.000139/lib/Test2/Require/Perl.pm
Test2-Suite-0.000139/t/regression/Test2-Mock.t
Test2-Suite-0.000139/t/behavior/no_leaks_any.t
Test2-Suite-0.000139/t/modules/Compare/Event.t
Test2-Suite-0.000139/t/modules/Compare/Array.t
Test2-Suite-0.000139/t/modules/Compare/Delta.t
Test2-Suite-0.000139/t/modules/Compare/Float.t
Test2-Suite-0.000139/t/modules/Compare/Regex.t
Test2-Suite-0.000139/t/modules/Compare/Undef.t
Test2-Suite-0.000139/t/modules/Tools/Compare.t
Test2-Suite-0.000139/t/modules/Tools/GenTemp.t
Test2-Suite-0.000139/t/modules/Tools/Subtest.t
Test2-Suite-0.000139/t/modules/Tools/Exports.t
Test2-Suite-0.000139/t/modules/Bundle/Simple.t
Test2-Suite-0.000139/t/modules/Workflow
Test2-Suite-0.000139/t/modules/Workflow/Task.t
Test2-Suite-0.000139/lib/Test2/Compare/Regex.pm
Test2-Suite-0.000139/lib/Test2/Compare/Delta.pm
Test2-Suite-0.000139/lib/Test2/Compare/Float.pm
Test2-Suite-0.000139/lib/Test2/Compare/Array.pm
Test2-Suite-0.000139/lib/Test2/Compare/Undef.pm
Test2-Suite-0.000139/lib/Test2/Compare/Event.pm
Test2-Suite-0.000139/lib/Test2/Tools/Exports.pm
Test2-Suite-0.000139/lib/Test2/Tools/Subtest.pm
Test2-Suite-0.000139/lib/Test2/Tools/GenTemp.pm
Test2-Suite-0.000139/lib/Test2/Tools/Compare.pm
Test2-Suite-0.000139/lib/Test2/Bundle/Simple.pm
Test2-Suite-0.000139/lib/Test2/Workflow
Test2-Suite-0.000139/lib/Test2/Workflow/Task.pm
Test2-Suite-0.000139/t/modules/Compare/Object.t
Test2-Suite-0.000139/t/modules/Compare/Custom.t
Test2-Suite-0.000139/t/modules/Compare/Number.t
Test2-Suite-0.000139/t/modules/Compare/Scalar.t
Test2-Suite-0.000139/t/modules/Compare/String.t
Test2-Suite-0.000139/t/modules/Tools/Warnings.t
Test2-Suite-0.000139/t/modules/Tools/Encoding.t
Test2-Suite-0.000139/t/modules/Require/EnvVar.t
Test2-Suite-0.000139/t/modules/Require/Module.t
Test2-Suite-0.000139/t/modules/Workflow/Build.t
Test2-Suite-0.000139/lib/Test2/Compare/Number.pm
Test2-Suite-0.000139/lib/Test2/Compare/Scalar.pm
Test2-Suite-0.000139/lib/Test2/Compare/Custom.pm
Test2-Suite-0.000139/lib/Test2/Compare/Object.pm
Test2-Suite-0.000139/lib/Test2/Compare/String.pm
Test2-Suite-0.000139/lib/Test2/Tools/Encoding.pm
Test2-Suite-0.000139/lib/Test2/Tools/Warnings.pm
Test2-Suite-0.000139/lib/Test2/Manual
Test2-Suite-0.000139/lib/Test2/Manual/Tooling.pm
Test2-Suite-0.000139/lib/Test2/Manual/Testing.pm
Test2-Suite-0.000139/lib/Test2/Manual/Anatomy.pm
Test2-Suite-0.000139/lib/Test2/Require/Module.pm
Test2-Suite-0.000139/lib/Test2/Require/EnvVar.pm
Test2-Suite-0.000139/lib/Test2/Workflow/Build.pm
Test2-Suite-0.000139/t/modules/Util/Table
Test2-Suite-0.000139/t/modules/Util/Table/Cell.t
Test2-Suite-0.000139/t/modules/Compare/Pattern.t
Test2-Suite-0.000139/t/modules/Tools/Exception.t
Test2-Suite-0.000139/t/modules/Bundle/Extended.t
Test2-Suite-0.000139/t/modules/Require/Threads.t
Test2-Suite-0.000139/t/modules/Workflow/Runner.t
Test2-Suite-0.000139/lib/Test2/Util/Table
Test2-Suite-0.000139/lib/Test2/Util/Table/Cell.pm
Test2-Suite-0.000139/lib/Test2/Compare/Pattern.pm
Test2-Suite-0.000139/lib/Test2/Compare/DeepRef.pm
Test2-Suite-0.000139/lib/Test2/Tools/Exception.pm
Test2-Suite-0.000139/lib/Test2/Bundle/Extended.pm
Test2-Suite-0.000139/lib/Test2/Require/Threads.pm
Test2-Suite-0.000139/lib/Test2/Workflow/Runner.pm
Test2-Suite-0.000139/t/behavior/no_done_testing.t
Test2-Suite-0.000139/t/behavior/no_leaks_no_iso.t
Test2-Suite-0.000139/t/modules/Compare/Wildcard.t
Test2-Suite-0.000139/t/modules/Plugin/DieOnFail.t
Test2-Suite-0.000139/t/modules/Require/RealFork.t
Test2-Suite-0.000139/t/modules/AsyncSubtest
Test2-Suite-0.000139/t/modules/AsyncSubtest/Hub.t
Test2-Suite-0.000139/lib/Test2/Compare/Wildcard.pm
Test2-Suite-0.000139/lib/Test2/Plugin/DieOnFail.pm
Test2-Suite-0.000139/lib/Test2/Require/RealFork.pm
Test2-Suite-0.000139/lib/Test2/AsyncSubtest
Test2-Suite-0.000139/lib/Test2/AsyncSubtest/Hub.pm
Test2-Suite-0.000139/t/regression/10-set_and_dne.t
Test2-Suite-0.000139/t/behavior/no_leaks_no_fork.t
Test2-Suite-0.000139/t/modules/Compare/EventMeta.t
Test2-Suite-0.000139/t/modules/Plugin/BailOnFail.t
Test2-Suite-0.000139/lib/Test2/Compare/EventMeta.pm
Test2-Suite-0.000139/lib/Test2/Compare/Negatable.pm
Test2-Suite-0.000139/lib/Test2/Plugin/BailOnFail.pm
Test2-Suite-0.000139/t/regression/todo_and_facets.t
Test2-Suite-0.000139/t/regression/43-bag-on-empty.t
Test2-Suite-0.000139/t/modules/Tools/AsyncSubtest.t
Test2-Suite-0.000139/t/modules/Plugin/ExitSummary.t
Test2-Suite-0.000139/t/modules/Workflow/BlockBase.t
Test2-Suite-0.000139/lib/Test2/Tools/AsyncSubtest.pm
Test2-Suite-0.000139/lib/Test2/Manual/Concurrency.pm
Test2-Suite-0.000139/lib/Test2/Manual/Anatomy
Test2-Suite-0.000139/lib/Test2/Manual/Anatomy/IPC.pm
Test2-Suite-0.000139/lib/Test2/Manual/Anatomy/API.pm
Test2-Suite-0.000139/lib/Test2/Plugin/ExitSummary.pm
Test2-Suite-0.000139/lib/Test2/Workflow/BlockBase.pm
Test2-Suite-0.000139/t/modules/Workflow/Task
Test2-Suite-0.000139/t/modules/Workflow/Task/Group.t
Test2-Suite-0.000139/lib/Test2/Manual/Contributing.pm
Test2-Suite-0.000139/lib/Test2/Manual/Testing
Test2-Suite-0.000139/lib/Test2/Manual/Testing/Todo.pm
Test2-Suite-0.000139/lib/Test2/Manual/Anatomy/Hubs.pm
Test2-Suite-0.000139/lib/Test2/Workflow/Task
Test2-Suite-0.000139/lib/Test2/Workflow/Task/Group.pm
Test2-Suite-0.000139/t/regression/Test2-Tools-Class.t
Test2-Suite-0.000139/t/behavior/no_leaks_no_threads.t
Test2-Suite-0.000139/t/modules/Util/Table/LineBreak.t
Test2-Suite-0.000139/t/modules/Tools/ClassicCompare.t
Test2-Suite-0.000139/t/modules/Workflow/Task/Action.t
Test2-Suite-0.000139/lib/Test2/Util/Table/LineBreak.pm
Test2-Suite-0.000139/lib/Test2/Tools/ClassicCompare.pm
Test2-Suite-0.000139/lib/Test2/Manual/Anatomy/Event.pm
Test2-Suite-0.000139/lib/Test2/Workflow/Task/Action.pm
Test2-Suite-0.000139/t/modules/Compare/OrderedSubset.t
Test2-Suite-0.000139/t/modules/Tools/ClassicCompare2.t
Test2-Suite-0.000139/t/modules/Require/AuthorTesting.t
Test2-Suite-0.000139/lib/Test2/Compare/OrderedSubset.pm
Test2-Suite-0.000139/lib/Test2/Require/AuthorTesting.pm
Test2-Suite-0.000139/t/acceptance/Workflow-Acceptance.t
Test2-Suite-0.000139/lib/Test2/Manual/Anatomy/Context.pm
Test2-Suite-0.000139/lib/Test2/Manual/Tooling
Test2-Suite-0.000139/lib/Test2/Manual/Tooling/Nesting.pm
Test2-Suite-0.000139/lib/Test2/Manual/Tooling/Testing.pm
Test2-Suite-0.000139/lib/Test2/Manual/Tooling/Subtest.pm
Test2-Suite-0.000139/lib/Test2/AsyncSubtest/Formatter.pm
Test2-Suite-0.000139/t/acceptance/Workflow-Acceptance2.t
Test2-Suite-0.000139/t/acceptance/Workflow-Acceptance3.t
Test2-Suite-0.000139/t/acceptance/Workflow-Acceptance5.t
Test2-Suite-0.000139/t/acceptance/Workflow-Acceptance4.t
Test2-Suite-0.000139/lib/Test2/Manual/Testing/Planning.pm
Test2-Suite-0.000139/lib/Test2/Manual/Anatomy/EndToEnd.pm
Test2-Suite-0.000139/lib/Test2/Manual/Testing/Migrating.pm
Test2-Suite-0.000139/lib/Test2/Manual/Anatomy/Utilities.pm
Test2-Suite-0.000139/lib/Test2/Manual/Tooling/FirstTool.pm
Test2-Suite-0.000139/lib/Test2/Manual/Tooling/Formatter.pm
Test2-Suite-0.000139/t/regression/27-1-Test2-Bundle-More.t
Test2-Suite-0.000139/t/modules/AsyncSubtest/Event
Test2-Suite-0.000139/t/modules/AsyncSubtest/Event/Detach.t
Test2-Suite-0.000139/t/modules/AsyncSubtest/Event/Attach.t
Test2-Suite-0.000139/lib/Test2/AsyncSubtest/Event
Test2-Suite-0.000139/lib/Test2/AsyncSubtest/Event/Attach.pm
Test2-Suite-0.000139/lib/Test2/AsyncSubtest/Event/Detach.pm
Test2-Suite-0.000139/lib/Test2/Manual/Tooling/TestBuilder.pm
Test2-Suite-0.000139/t/regression/27-2-Test2-Tools-Compare.t
Test2-Suite-0.000139/lib/Test2/Manual/Testing/Introduction.pm
Test2-Suite-0.000139/lib/Test2/Manual/Tooling/Plugin
Test2-Suite-0.000139/lib/Test2/Manual/Tooling/Plugin/TestExit.pm
Test2-Suite-0.000139/t/regression/async_subtest_missing_parent.t
Test2-Suite-0.000139/lib/Test2/Manual/Tooling/Plugin/ToolStarts.pm
Test2-Suite-0.000139/lib/Test2/Manual/Tooling/Plugin/TestingDone.pm
Test2-Suite-0.000139/t/regression/27-3-Test2-Tools-ClassicCompare.t
Test2-Suite-0.000139/lib/Test2/Manual/Tooling/Plugin/ToolCompletes.pm

  CPAN.pm: Building E/EX/EXODIST/Test2-Suite-0.000139.tar.gz

Checking if your kit is complete...
Looks good
Warning: prerequisite Importer 0.024 not found.
Warning: prerequisite Scope::Guard 0 not found.
Warning: prerequisite Sub::Info 0.002 not found.
Warning: prerequisite Term::Table 0.013 not found.
Generating a Unix-style Makefile
Writing Makefile for Test2::Suite
Writing MYMETA.yml and MYMETA.json
---- Unsatisfied dependencies detected during ----
----    EXODIST/Test2-Suite-0.000139.tar.gz   ----
    Scope::Guard [requires]
    Sub::Info [requires]
    Term::Table [requires]
    Importer [requires]
Running make test
  Delayed until after prerequisites
Running make install
  Delayed until after prerequisites
Running install for module 'Scope::Guard'
Running make for C/CH/CHOCOLATE/Scope-Guard-0.21.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/C/CH/CHOCOLATE/Scope-Guard-0.21.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/C/CH/CHOCOLATE/CHECKSUMS
Checksum for /root/.cpan/sources/authors/id/C/CH/CHOCOLATE/Scope-Guard-0.21.tar.gz ok
Scope-Guard-0.21/
Scope-Guard-0.21/META.yml
Scope-Guard-0.21/README
Scope-Guard-0.21/lib/
Scope-Guard-0.21/lib/Scope/
Scope-Guard-0.21/lib/Scope/Guard.pm
Scope-Guard-0.21/MANIFEST
Scope-Guard-0.21/Changes
Scope-Guard-0.21/Makefile.PL
Scope-Guard-0.21/META.json
Scope-Guard-0.21/t/
Scope-Guard-0.21/t/new.t
Scope-Guard-0.21/t/guard.t
Scope-Guard-0.21/t/scope_guard.t

  CPAN.pm: Building C/CH/CHOCOLATE/Scope-Guard-0.21.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for Scope::Guard
Writing MYMETA.yml and MYMETA.json
cp lib/Scope/Guard.pm blib/lib/Scope/Guard.pm
Manifying 1 pod document
  CHOCOLATE/Scope-Guard-0.21.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/guard.t ........ ok
t/new.t .......... ok
t/scope_guard.t .. ok
All tests successful.
Files=3, Tests=54,  0 wallclock secs ( 0.02 usr  0.00 sys +  0.10 cusr  0.02 csys =  0.14 CPU)
Result: PASS
  CHOCOLATE/Scope-Guard-0.21.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/Scope-Guard-0.21-lhZaoj/blib/arch /root/.cpan/build/Scope-Guard-0.21-lhZaoj/blib/lib to PERL5LIB for 'install'
Manifying 1 pod document
Installing /usr/local/share/perl5/Scope/Guard.pm
Installing /usr/local/share/man/man3/Scope::Guard.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  CHOCOLATE/Scope-Guard-0.21.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'Sub::Info'
Running make for E/EX/EXODIST/Sub-Info-0.002.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/E/EX/EXODIST/Sub-Info-0.002.tar.gz
Checksum for /root/.cpan/sources/authors/id/E/EX/EXODIST/Sub-Info-0.002.tar.gz ok
Sub-Info-0.002
Sub-Info-0.002/README
Sub-Info-0.002/LICENSE
Sub-Info-0.002/Changes
Sub-Info-0.002/t
Sub-Info-0.002/t/Sub.t
Sub-Info-0.002/MANIFEST
Sub-Info-0.002/cpanfile
Sub-Info-0.002/META.yml
Sub-Info-0.002/META.json
Sub-Info-0.002/README.md
Sub-Info-0.002/Makefile.PL
Sub-Info-0.002/lib/Sub
Sub-Info-0.002/lib/Sub/Info.pm

  CPAN.pm: Building E/EX/EXODIST/Sub-Info-0.002.tar.gz

Checking if your kit is complete...
Looks good
Warning: prerequisite Importer 0.024 not found.
Generating a Unix-style Makefile
Writing Makefile for Sub::Info
Writing MYMETA.yml and MYMETA.json
---- Unsatisfied dependencies detected during ----
----       EXODIST/Sub-Info-0.002.tar.gz      ----
    Importer [requires]
Running make test
  Delayed until after prerequisites
Running make install
  Delayed until after prerequisites
Running install for module 'Importer'
Running make for E/EX/EXODIST/Importer-0.026.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/E/EX/EXODIST/Importer-0.026.tar.gz
Checksum for /root/.cpan/sources/authors/id/E/EX/EXODIST/Importer-0.026.tar.gz ok
Importer-0.026
Importer-0.026/README
Importer-0.026/LICENSE
Importer-0.026/Changes
Importer-0.026/MANIFEST
Importer-0.026/cpanfile
Importer-0.026/META.yml
Importer-0.026/README.md
Importer-0.026/t
Importer-0.026/t/units.t
Importer-0.026/META.json
Importer-0.026/t/Simple.t
Importer-0.026/t/import.t
Importer-0.026/t/all_tag.t
Importer-0.026/t/missing.t
Importer-0.026/Makefile.PL
Importer-0.026/lib
Importer-0.026/lib/Importer.pm
Importer-0.026/t/export_fail.t

  CPAN.pm: Building E/EX/EXODIST/Importer-0.026.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for Importer
Writing MYMETA.yml and MYMETA.json
cp lib/Importer.pm blib/lib/Importer.pm
Manifying 1 pod document
  EXODIST/Importer-0.026.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/all_tag.t ...... ok
t/export_fail.t .. ok
t/import.t ....... ok
t/missing.t ...... ok
t/Simple.t ....... ok
t/units.t ........ ok
All tests successful.
Files=6, Tests=41,  0 wallclock secs ( 0.04 usr  0.01 sys +  0.26 cusr  0.03 csys =  0.34 CPU)
Result: PASS
  EXODIST/Importer-0.026.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/Importer-0.026-9Xej4J/blib/arch /root/.cpan/build/Importer-0.026-9Xej4J/blib/lib to PERL5LIB for 'install'
Manifying 1 pod document
Installing /usr/local/share/perl5/Importer.pm
Installing /usr/local/share/man/man3/Importer.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  EXODIST/Importer-0.026.tar.gz
  /usr/bin/make install  -- OK
Running make for E/EX/EXODIST/Sub-Info-0.002.tar.gz
  Has already been unwrapped into directory /root/.cpan/build/Sub-Info-0.002-WZkVGI

  CPAN.pm: Building E/EX/EXODIST/Sub-Info-0.002.tar.gz

cp lib/Sub/Info.pm blib/lib/Sub/Info.pm
Manifying 1 pod document
  EXODIST/Sub-Info-0.002.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/Sub.t .. ok
All tests successful.
Files=1, Tests=68,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.03 cusr  0.00 csys =  0.04 CPU)
Result: PASS
  EXODIST/Sub-Info-0.002.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/Sub-Info-0.002-WZkVGI/blib/arch /root/.cpan/build/Sub-Info-0.002-WZkVGI/blib/lib to PERL5LIB for 'install'
Manifying 1 pod document
Installing /usr/local/share/perl5/Sub/Info.pm
Installing /usr/local/share/man/man3/Sub::Info.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  EXODIST/Sub-Info-0.002.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'Term::Table'
Running make for E/EX/EXODIST/Term-Table-0.015.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/E/EX/EXODIST/Term-Table-0.015.tar.gz
Checksum for /root/.cpan/sources/authors/id/E/EX/EXODIST/Term-Table-0.015.tar.gz ok
Term-Table-0.015/
Term-Table-0.015/lib/
Term-Table-0.015/lib/Term/
Term-Table-0.015/lib/Term/Table/
Term-Table-0.015/lib/Term/Table/CellStack.pm
Term-Table-0.015/lib/Term/Table/LineBreak.pm
Term-Table-0.015/lib/Term/Table/HashBase.pm
Term-Table-0.015/lib/Term/Table/Spacer.pm
Term-Table-0.015/lib/Term/Table/Cell.pm
Term-Table-0.015/lib/Term/Table/Util.pm
Term-Table-0.015/lib/Term/Table.pm
Term-Table-0.015/appveyor.yml
Term-Table-0.015/Makefile.PL
Term-Table-0.015/README.md
Term-Table-0.015/META.json
Term-Table-0.015/t/
Term-Table-0.015/t/honor_env_in_non_tty.t
Term-Table-0.015/t/bad_blank_line.t
Term-Table-0.015/t/Table/
Term-Table-0.015/t/Table/CellStack.t
Term-Table-0.015/t/Table/LineBreak.t
Term-Table-0.015/t/Table/Cell.t
Term-Table-0.015/t/HashBase.t
Term-Table-0.015/t/issue-9.t
Term-Table-0.015/t/Table.t
Term-Table-0.015/META.yml
Term-Table-0.015/cpanfile
Term-Table-0.015/MANIFEST
Term-Table-0.015/Changes
Term-Table-0.015/LICENSE
Term-Table-0.015/README

  CPAN.pm: Building E/EX/EXODIST/Term-Table-0.015.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for Term::Table
Writing MYMETA.yml and MYMETA.json
cp lib/Term/Table/CellStack.pm blib/lib/Term/Table/CellStack.pm
cp lib/Term/Table/Util.pm blib/lib/Term/Table/Util.pm
cp lib/Term/Table/Spacer.pm blib/lib/Term/Table/Spacer.pm
cp lib/Term/Table/LineBreak.pm blib/lib/Term/Table/LineBreak.pm
cp lib/Term/Table/HashBase.pm blib/lib/Term/Table/HashBase.pm
cp lib/Term/Table/Cell.pm blib/lib/Term/Table/Cell.pm
cp lib/Term/Table.pm blib/lib/Term/Table.pm
Manifying 6 pod documents
  EXODIST/Term-Table-0.015.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t t/Table/*.t
t/bad_blank_line.t ........ ok
t/HashBase.t .............. ok
t/honor_env_in_non_tty.t .. ok
t/issue-9.t ............... ok
t/Table.t ................. ok
t/Table/Cell.t ............ ok
t/Table/CellStack.t ....... ok
t/Table/LineBreak.t ....... ok
All tests successful.
Files=8, Tests=82,  1 wallclock secs ( 0.03 usr  0.01 sys +  0.31 cusr  0.06 csys =  0.41 CPU)
Result: PASS
  EXODIST/Term-Table-0.015.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/Term-Table-0.015-7FZ5q9/blib/arch /root/.cpan/build/Term-Table-0.015-7FZ5q9/blib/lib to PERL5LIB for 'install'
Manifying 6 pod documents
Installing /usr/local/share/perl5/Term/Table.pm
Installing /usr/local/share/perl5/Term/Table/Spacer.pm
Installing /usr/local/share/perl5/Term/Table/HashBase.pm
Installing /usr/local/share/perl5/Term/Table/Util.pm
Installing /usr/local/share/perl5/Term/Table/LineBreak.pm
Installing /usr/local/share/perl5/Term/Table/Cell.pm
Installing /usr/local/share/perl5/Term/Table/CellStack.pm
Installing /usr/local/share/man/man3/Term::Table::CellStack.3pm
Installing /usr/local/share/man/man3/Term::Table::Cell.3pm
Installing /usr/local/share/man/man3/Term::Table::Util.3pm
Installing /usr/local/share/man/man3/Term::Table::LineBreak.3pm
Installing /usr/local/share/man/man3/Term::Table.3pm
Installing /usr/local/share/man/man3/Term::Table::HashBase.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  EXODIST/Term-Table-0.015.tar.gz
  /usr/bin/make install  -- OK
Running make for E/EX/EXODIST/Test2-Suite-0.000139.tar.gz
  Has already been unwrapped into directory /root/.cpan/build/Test2-Suite-0.000139-iLiO6R

  CPAN.pm: Building E/EX/EXODIST/Test2-Suite-0.000139.tar.gz

cp lib/Test2/Bundle/Simple.pm blib/lib/Test2/Bundle/Simple.pm
cp lib/Test2/Compare/Float.pm blib/lib/Test2/Compare/Float.pm
cp lib/Test2/Compare/DeepRef.pm blib/lib/Test2/Compare/DeepRef.pm
cp lib/Test2/Compare/String.pm blib/lib/Test2/Compare/String.pm
cp lib/Test2/Compare/Ref.pm blib/lib/Test2/Compare/Ref.pm
cp lib/Test2/Compare/Hash.pm blib/lib/Test2/Compare/Hash.pm
cp lib/Test2/Compare/Array.pm blib/lib/Test2/Compare/Array.pm
cp lib/Test2/Compare/Number.pm blib/lib/Test2/Compare/Number.pm
cp lib/Test2/Compare/Delta.pm blib/lib/Test2/Compare/Delta.pm
cp lib/Test2/Compare.pm blib/lib/Test2/Compare.pm
cp lib/Test2/Compare/EventMeta.pm blib/lib/Test2/Compare/EventMeta.pm
cp lib/Test2/Compare/Scalar.pm blib/lib/Test2/Compare/Scalar.pm
cp lib/Test2/Compare/Pattern.pm blib/lib/Test2/Compare/Pattern.pm
cp lib/Test2/Compare/Bool.pm blib/lib/Test2/Compare/Bool.pm
cp lib/Test2/Compare/Bag.pm blib/lib/Test2/Compare/Bag.pm
cp lib/Test2/Compare/Base.pm blib/lib/Test2/Compare/Base.pm
cp lib/Test2/Compare/Regex.pm blib/lib/Test2/Compare/Regex.pm
cp lib/Test2/Bundle/More.pm blib/lib/Test2/Bundle/More.pm
cp lib/Test2/Compare/Event.pm blib/lib/Test2/Compare/Event.pm
cp lib/Test2/Manual/Anatomy/API.pm blib/lib/Test2/Manual/Anatomy/API.pm
cp lib/Test2/Manual/Anatomy.pm blib/lib/Test2/Manual/Anatomy.pm
cp lib/Test2/Compare/Custom.pm blib/lib/Test2/Compare/Custom.pm
cp lib/Test2/Bundle.pm blib/lib/Test2/Bundle.pm
cp lib/Test2/Compare/Meta.pm blib/lib/Test2/Compare/Meta.pm
cp lib/Test2/Manual.pm blib/lib/Test2/Manual.pm
cp lib/Test2/AsyncSubtest/Event/Detach.pm blib/lib/Test2/AsyncSubtest/Event/Detach.pm
cp lib/Test2/Manual/Anatomy/Context.pm blib/lib/Test2/Manual/Anatomy/Context.pm
cp lib/Test2/AsyncSubtest.pm blib/lib/Test2/AsyncSubtest.pm
cp lib/Test2/Compare/Isa.pm blib/lib/Test2/Compare/Isa.pm
cp lib/Test2/Compare/Object.pm blib/lib/Test2/Compare/Object.pm
cp lib/Test2/Bundle/Extended.pm blib/lib/Test2/Bundle/Extended.pm
cp lib/Test2/AsyncSubtest/Formatter.pm blib/lib/Test2/AsyncSubtest/Formatter.pm
cp lib/Test2/Compare/Wildcard.pm blib/lib/Test2/Compare/Wildcard.pm
cp lib/Test2/Compare/Set.pm blib/lib/Test2/Compare/Set.pm
cp lib/Test2/Compare/OrderedSubset.pm blib/lib/Test2/Compare/OrderedSubset.pm
cp lib/Test2/AsyncSubtest/Hub.pm blib/lib/Test2/AsyncSubtest/Hub.pm
cp lib/Test2/AsyncSubtest/Event/Attach.pm blib/lib/Test2/AsyncSubtest/Event/Attach.pm
cp lib/Test2/Compare/Negatable.pm blib/lib/Test2/Compare/Negatable.pm
cp lib/Test2/Compare/Undef.pm blib/lib/Test2/Compare/Undef.pm
cp lib/Test2/Mock.pm blib/lib/Test2/Mock.pm
cp lib/Test2/Plugin/ExitSummary.pm blib/lib/Test2/Plugin/ExitSummary.pm
cp lib/Test2/Manual/Tooling.pm blib/lib/Test2/Manual/Tooling.pm
cp lib/Test2/Manual/Anatomy/EndToEnd.pm blib/lib/Test2/Manual/Anatomy/EndToEnd.pm
cp lib/Test2/Manual/Tooling/FirstTool.pm blib/lib/Test2/Manual/Tooling/FirstTool.pm
cp lib/Test2/Plugin/UTF8.pm blib/lib/Test2/Plugin/UTF8.pm
cp lib/Test2/Manual/Tooling/TestBuilder.pm blib/lib/Test2/Manual/Tooling/TestBuilder.pm
cp lib/Test2/Manual/Testing.pm blib/lib/Test2/Manual/Testing.pm
cp lib/Test2/Manual/Concurrency.pm blib/lib/Test2/Manual/Concurrency.pm
cp lib/Test2/Plugin.pm blib/lib/Test2/Plugin.pm
cp lib/Test2/Require/EnvVar.pm blib/lib/Test2/Require/EnvVar.pm
cp lib/Test2/Manual/Tooling/Nesting.pm blib/lib/Test2/Manual/Tooling/Nesting.pm
cp lib/Test2/Plugin/BailOnFail.pm blib/lib/Test2/Plugin/BailOnFail.pm
cp lib/Test2/Manual/Testing/Migrating.pm blib/lib/Test2/Manual/Testing/Migrating.pm
cp lib/Test2/Manual/Contributing.pm blib/lib/Test2/Manual/Contributing.pm
cp lib/Test2/Manual/Testing/Planning.pm blib/lib/Test2/Manual/Testing/Planning.pm
cp lib/Test2/Manual/Anatomy/IPC.pm blib/lib/Test2/Manual/Anatomy/IPC.pm
cp lib/Test2/Manual/Anatomy/Event.pm blib/lib/Test2/Manual/Anatomy/Event.pm
cp lib/Test2/Plugin/SRand.pm blib/lib/Test2/Plugin/SRand.pm
cp lib/Test2/Plugin/Times.pm blib/lib/Test2/Plugin/Times.pm
cp lib/Test2/Manual/Tooling/Plugin/TestingDone.pm blib/lib/Test2/Manual/Tooling/Plugin/TestingDone.pm
cp lib/Test2/Manual/Tooling/Subtest.pm blib/lib/Test2/Manual/Tooling/Subtest.pm
cp lib/Test2/Require/AuthorTesting.pm blib/lib/Test2/Require/AuthorTesting.pm
cp lib/Test2/Manual/Testing/Introduction.pm blib/lib/Test2/Manual/Testing/Introduction.pm
cp lib/Test2/Manual/Tooling/Plugin/ToolStarts.pm blib/lib/Test2/Manual/Tooling/Plugin/ToolStarts.pm
cp lib/Test2/Manual/Testing/Todo.pm blib/lib/Test2/Manual/Testing/Todo.pm
cp lib/Test2/Manual/Anatomy/Hubs.pm blib/lib/Test2/Manual/Anatomy/Hubs.pm
cp lib/Test2/Manual/Anatomy/Utilities.pm blib/lib/Test2/Manual/Anatomy/Utilities.pm
cp lib/Test2/Require.pm blib/lib/Test2/Require.pm
cp lib/Test2/Manual/Tooling/Plugin/TestExit.pm blib/lib/Test2/Manual/Tooling/Plugin/TestExit.pm
cp lib/Test2/Manual/Tooling/Plugin/ToolCompletes.pm blib/lib/Test2/Manual/Tooling/Plugin/ToolCompletes.pm
cp lib/Test2/Plugin/DieOnFail.pm blib/lib/Test2/Plugin/DieOnFail.pm
cp lib/Test2/Manual/Tooling/Testing.pm blib/lib/Test2/Manual/Tooling/Testing.pm
cp lib/Test2/Manual/Tooling/Formatter.pm blib/lib/Test2/Manual/Tooling/Formatter.pm
cp lib/Test2/Util/Times.pm blib/lib/Test2/Util/Times.pm
cp lib/Test2/Tools/Exports.pm blib/lib/Test2/Tools/Exports.pm
cp lib/Test2/Workflow/Runner.pm blib/lib/Test2/Workflow/Runner.pm
cp lib/Test2/Tools/AsyncSubtest.pm blib/lib/Test2/Tools/AsyncSubtest.pm
cp lib/Test2/Util/Table/LineBreak.pm blib/lib/Test2/Util/Table/LineBreak.pm
cp lib/Test2/Tools/Defer.pm blib/lib/Test2/Tools/Defer.pm
cp lib/Test2/Tools/Grab.pm blib/lib/Test2/Tools/Grab.pm
cp lib/Test2/Tools/Basic.pm blib/lib/Test2/Tools/Basic.pm
cp lib/Test2/Util/Grabber.pm blib/lib/Test2/Util/Grabber.pm
cp lib/Test2/Tools/Mock.pm blib/lib/Test2/Tools/Mock.pm
cp lib/Test2/Tools/Ref.pm blib/lib/Test2/Tools/Ref.pm
cp lib/Test2/Require/RealFork.pm blib/lib/Test2/Require/RealFork.pm
cp lib/Test2/Util/Stash.pm blib/lib/Test2/Util/Stash.pm
cp lib/Test2/Require/Fork.pm blib/lib/Test2/Require/Fork.pm
cp lib/Test2/Require/Module.pm blib/lib/Test2/Require/Module.pm
cp lib/Test2/Util/Table/Cell.pm blib/lib/Test2/Util/Table/Cell.pm
cp lib/Test2/Workflow/BlockBase.pm blib/lib/Test2/Workflow/BlockBase.pm
cp lib/Test2/Util/Term.pm blib/lib/Test2/Util/Term.pm
cp lib/Test2/Tools/Event.pm blib/lib/Test2/Tools/Event.pm
cp lib/Test2/Require/Threads.pm blib/lib/Test2/Require/Threads.pm
cp lib/Test2/Tools/Target.pm blib/lib/Test2/Tools/Target.pm
cp lib/Test2/Tools/Spec.pm blib/lib/Test2/Tools/Spec.pm
cp lib/Test2/Tools/Tester.pm blib/lib/Test2/Tools/Tester.pm
cp lib/Test2/Util/Sub.pm blib/lib/Test2/Util/Sub.pm
cp lib/Test2/Require/Perl.pm blib/lib/Test2/Require/Perl.pm
cp lib/Test2/Tools.pm blib/lib/Test2/Tools.pm
cp lib/Test2/Workflow/Task.pm blib/lib/Test2/Workflow/Task.pm
cp lib/Test2/Tools/Compare.pm blib/lib/Test2/Tools/Compare.pm
cp lib/Test2/Workflow.pm blib/lib/Test2/Workflow.pm
cp lib/Test2/Todo.pm blib/lib/Test2/Todo.pm
cp lib/Test2/Tools/ClassicCompare.pm blib/lib/Test2/Tools/ClassicCompare.pm
cp lib/Test2/Tools/Exception.pm blib/lib/Test2/Tools/Exception.pm
cp lib/Test2/Tools/Class.pm blib/lib/Test2/Tools/Class.pm
cp lib/Test2/Tools/GenTemp.pm blib/lib/Test2/Tools/GenTemp.pm
cp lib/Test2/Suite.pm blib/lib/Test2/Suite.pm
cp lib/Test2/Tools/Subtest.pm blib/lib/Test2/Tools/Subtest.pm
cp lib/Test2/Util/Ref.pm blib/lib/Test2/Util/Ref.pm
cp lib/Test2/Tools/Warnings.pm blib/lib/Test2/Tools/Warnings.pm
cp lib/Test2/Tools/Encoding.pm blib/lib/Test2/Tools/Encoding.pm
cp lib/Test2/Util/Table.pm blib/lib/Test2/Util/Table.pm
cp lib/Test2/Workflow/Build.pm blib/lib/Test2/Workflow/Build.pm
cp lib/Test2/V0.pm blib/lib/Test2/V0.pm
cp lib/Test2/Workflow/Task/Group.pm blib/lib/Test2/Workflow/Task/Group.pm
cp lib/Test2/Workflow/Task/Action.pm blib/lib/Test2/Workflow/Task/Action.pm
Manifying 34 pod documents
Manifying 29 pod documents
Manifying 35 pod documents
Manifying 16 pod documents
  EXODIST/Test2-Suite-0.000139.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t t/acceptance/*.t t/behavior/*.t t/modules/*.t t/modules/AsyncSubtest/*.t t/modules/AsyncSubtest/Event/*.t t/modules/Bundle/*.t t/modules/Compare/*.t t/modules/Plugin/*.t t/modules/Require/*.t t/modules/Tools/*.t t/modules/Util/*.t t/modules/Util/Table/*.t t/modules/Workflow/*.t t/modules/Workflow/Task/*.t t/regression/*.t
t/00-report.t ................................... #
# DIAGNOSTICS INFO IN CASE OF FAILURE:
# +------+----------+
# | perl | 5.010001 |
# +------+----------+
# +-----------------+-----------+
# | CAPABILITY      | SUPPORTED |
# +-----------------+-----------+
# | CAN_FORK        | Yes       |
# | CAN_REALLY_FORK | Yes       |
# | CAN_THREAD      | Yes       |
# +-----------------+-----------+
# +-------------------+----------+
# | DEPENDENCY        | VERSION  |
# +-------------------+----------+
# | B                 | 1.22     |
# | Carp              | 1.11     |
# | Exporter          | 5.63     |
# | Importer          | 0.026    |
# | Module::Pluggable | 3.9      |
# | Scalar::Util      | 1.55     |
# | Scope::Guard      | 0.21     |
# | Sub::Info         | 0.002    |
# | Term::Table       | 0.015    |
# | Test2             | 1.302183 |
# | Time::HiRes       | 1.9721   |
# | overload          | 1.07     |
# | utf8              | 1.07     |
# +-------------------+----------+
# +--------------------+---------+
# | OPTIONAL           | VERSION |
# +--------------------+---------+
# | Sub::Name          | N/A     |
# | Term::ReadKey      | N/A     |
# | Term::Size::Any    | N/A     |
# | Unicode::GCString  | N/A     |
# | Unicode::LineBreak | N/A     |
# +--------------------+---------+
t/00-report.t ................................... ok
t/acceptance/OO.t ............................... ok
t/acceptance/skip.t ............................. ok
t/acceptance/spec.t ............................. ok
t/acceptance/Tools.t ............................ ok
t/acceptance/Workflow-Acceptance.t .............. ok
t/acceptance/Workflow-Acceptance2.t ............. ok
t/acceptance/Workflow-Acceptance3.t ............. ok
t/acceptance/Workflow-Acceptance4.t ............. ok
t/acceptance/Workflow-Acceptance5.t ............. ok
t/behavior/async_trace.t ........................ ok
t/behavior/filtering.t .......................... ok
t/behavior/Mocking.t ............................ ok
t/behavior/no_done_testing.t .................... ok
t/behavior/no_leaks_any.t ....................... ok
t/behavior/no_leaks_no_fork.t ................... ok
t/behavior/no_leaks_no_iso.t .................... ok
t/behavior/no_leaks_no_threads.t ................ ok
t/behavior/simple.t ............................. ok
t/load_manual.t ................................. ok
t/modules/AsyncSubtest.t ........................ ok
t/modules/AsyncSubtest/Event/Attach.t ........... ok
t/modules/AsyncSubtest/Event/Detach.t ........... ok
t/modules/AsyncSubtest/Hub.t .................... ok
t/modules/Bundle.t .............................. ok
t/modules/Bundle/Extended.t ..................... ok
t/modules/Bundle/More.t ......................... ok
t/modules/Bundle/Simple.t ....................... ok
t/modules/Compare.t ............................. ok
t/modules/Compare/Array.t ....................... ok
t/modules/Compare/Bag.t ......................... ok
t/modules/Compare/Base.t ........................ ok
t/modules/Compare/Bool.t ........................ ok
t/modules/Compare/Custom.t ...................... ok
t/modules/Compare/Delta.t ....................... ok
t/modules/Compare/Event.t ....................... ok
t/modules/Compare/EventMeta.t ................... ok
t/modules/Compare/Float.t ....................... ok
t/modules/Compare/Hash.t ........................ ok
t/modules/Compare/Isa.t ......................... ok
t/modules/Compare/Meta.t ........................ ok
t/modules/Compare/Number.t ...................... ok
t/modules/Compare/Object.t ...................... ok
t/modules/Compare/OrderedSubset.t ............... ok
t/modules/Compare/Pattern.t ..................... ok
t/modules/Compare/Ref.t ......................... ok
t/modules/Compare/Regex.t ....................... ok
t/modules/Compare/Scalar.t ...................... ok
t/modules/Compare/Set.t ......................... ok
t/modules/Compare/String.t ...................... ok
t/modules/Compare/Undef.t ....................... ok
t/modules/Compare/Wildcard.t .................... ok
t/modules/Mock.t ................................ ok
t/modules/Plugin.t .............................. ok
t/modules/Plugin/BailOnFail.t ................... ok
t/modules/Plugin/DieOnFail.t .................... ok
t/modules/Plugin/ExitSummary.t .................. ok
t/modules/Plugin/SRand.t ........................ ok
t/modules/Plugin/Times.t ........................ ok
t/modules/Plugin/UTF8.t ......................... ok
t/modules/Require.t ............................. ok
t/modules/Require/AuthorTesting.t ............... ok
t/modules/Require/EnvVar.t ...................... ok
t/modules/Require/Fork.t ........................ ok
t/modules/Require/Module.t ...................... ok
t/modules/Require/Perl.t ........................ ok
t/modules/Require/RealFork.t .................... ok
t/modules/Require/Threads.t ..................... ok
t/modules/Suite.t ............................... ok
t/modules/Todo.t ................................ ok
t/modules/Tools.t ............................... ok
t/modules/Tools/AsyncSubtest.t .................. ok
t/modules/Tools/Basic.t ......................... ok
t/modules/Tools/Class.t ......................... ok
t/modules/Tools/ClassicCompare.t ................ ok
t/modules/Tools/ClassicCompare2.t ............... ok
t/modules/Tools/Compare.t ....................... ok
t/modules/Tools/Defer.t ......................... ok
t/modules/Tools/Encoding.t ...................... ok
t/modules/Tools/Event.t ......................... ok
t/modules/Tools/Exception.t ..................... ok
t/modules/Tools/Exports.t ....................... ok
t/modules/Tools/GenTemp.t ....................... ok
t/modules/Tools/Grab.t .......................... ok
t/modules/Tools/Mock.t .......................... ok
t/modules/Tools/Ref.t ........................... ok
t/modules/Tools/Spec.t .......................... skipped: Tests not yet written
t/modules/Tools/Subtest.t ....................... ok
t/modules/Tools/Target.t ........................ ok
t/modules/Tools/Tester.t ........................ ok
t/modules/Tools/Warnings.t ...................... ok
t/modules/Util/Grabber.t ........................ ok
t/modules/Util/Ref.t ............................ ok
t/modules/Util/Stash.t .......................... ok
t/modules/Util/Sub.t ............................ ok
t/modules/Util/Table.t .......................... ok
t/modules/Util/Table/Cell.t ..................... ok
t/modules/Util/Table/LineBreak.t ................ ok
t/modules/Util/Times.t .......................... ok
t/modules/V0.t .................................. ok
t/modules/Workflow.t ............................ skipped: Tests not yet written
t/modules/Workflow/BlockBase.t .................. skipped: Tests not yet written
t/modules/Workflow/Build.t ...................... skipped: Tests not yet written
t/modules/Workflow/Runner.t ..................... skipped: Tests not yet written
t/modules/Workflow/Task.t ....................... skipped: Tests not yet written
t/modules/Workflow/Task/Action.t ................ ok
t/modules/Workflow/Task/Group.t ................. skipped: Tests not yet written
t/regression/10-set_and_dne.t ................... ok
t/regression/132-bool.t ......................... skipped: Author test, set the $AUTHOR_TESTING environment variable to run it
t/regression/27-1-Test2-Bundle-More.t ........... ok
t/regression/27-2-Test2-Tools-Compare.t ......... ok
t/regression/27-3-Test2-Tools-ClassicCompare.t .. ok
t/regression/43-bag-on-empty.t .................. ok
t/regression/async_subtest_missing_parent.t ..... ok
t/regression/Test2-Mock.t ....................... ok
t/regression/Test2-Tools-Class.t ................ ok
t/regression/todo_and_facets.t .................. ok
t/regression/utf8-mock.t ........................ ok
All tests successful.
Files=118, Tests=766, 11 wallclock secs ( 0.37 usr  0.15 sys +  9.56 cusr  1.68 csys = 11.76 CPU)
Result: PASS
  EXODIST/Test2-Suite-0.000139.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/Test2-Suite-0.000139-iLiO6R/blib/arch /root/.cpan/build/Test2-Suite-0.000139-iLiO6R/blib/lib to PERL5LIB for 'install'
Manifying 34 pod documents
Manifying 29 pod documents
Manifying 35 pod documents
Manifying 16 pod documents
Installing /usr/local/share/perl5/Test2/Workflow.pm
Installing /usr/local/share/perl5/Test2/Tools.pm
Installing /usr/local/share/perl5/Test2/AsyncSubtest.pm
Installing /usr/local/share/perl5/Test2/V0.pm
Installing /usr/local/share/perl5/Test2/Require.pm
Installing /usr/local/share/perl5/Test2/Todo.pm
Installing /usr/local/share/perl5/Test2/Plugin.pm
Installing /usr/local/share/perl5/Test2/Compare.pm
Installing /usr/local/share/perl5/Test2/Bundle.pm
Installing /usr/local/share/perl5/Test2/Suite.pm
Installing /usr/local/share/perl5/Test2/Manual.pm
Installing /usr/local/share/perl5/Test2/Mock.pm
Installing /usr/local/share/perl5/Test2/Tools/Ref.pm
Installing /usr/local/share/perl5/Test2/Tools/Defer.pm
Installing /usr/local/share/perl5/Test2/Tools/Spec.pm
Installing /usr/local/share/perl5/Test2/Tools/Encoding.pm
Installing /usr/local/share/perl5/Test2/Tools/Basic.pm
Installing /usr/local/share/perl5/Test2/Tools/AsyncSubtest.pm
Installing /usr/local/share/perl5/Test2/Tools/Tester.pm
Installing /usr/local/share/perl5/Test2/Tools/Event.pm
Installing /usr/local/share/perl5/Test2/Tools/GenTemp.pm
Installing /usr/local/share/perl5/Test2/Tools/ClassicCompare.pm
Installing /usr/local/share/perl5/Test2/Tools/Warnings.pm
Installing /usr/local/share/perl5/Test2/Tools/Grab.pm
Installing /usr/local/share/perl5/Test2/Tools/Compare.pm
Installing /usr/local/share/perl5/Test2/Tools/Subtest.pm
Installing /usr/local/share/perl5/Test2/Tools/Exception.pm
Installing /usr/local/share/perl5/Test2/Tools/Exports.pm
Installing /usr/local/share/perl5/Test2/Tools/Class.pm
Installing /usr/local/share/perl5/Test2/Tools/Target.pm
Installing /usr/local/share/perl5/Test2/Tools/Mock.pm
Installing /usr/local/share/perl5/Test2/Plugin/ExitSummary.pm
Installing /usr/local/share/perl5/Test2/Plugin/DieOnFail.pm
Installing /usr/local/share/perl5/Test2/Plugin/Times.pm
Installing /usr/local/share/perl5/Test2/Plugin/BailOnFail.pm
Installing /usr/local/share/perl5/Test2/Plugin/UTF8.pm
Installing /usr/local/share/perl5/Test2/Plugin/SRand.pm
Installing /usr/local/share/perl5/Test2/Require/AuthorTesting.pm
Installing /usr/local/share/perl5/Test2/Require/Perl.pm
Installing /usr/local/share/perl5/Test2/Require/RealFork.pm
Installing /usr/local/share/perl5/Test2/Require/Module.pm
Installing /usr/local/share/perl5/Test2/Require/Fork.pm
Installing /usr/local/share/perl5/Test2/Require/Threads.pm
Installing /usr/local/share/perl5/Test2/Require/EnvVar.pm
Installing /usr/local/share/perl5/Test2/Util/Ref.pm
Installing /usr/local/share/perl5/Test2/Util/Sub.pm
Installing /usr/local/share/perl5/Test2/Util/Stash.pm
Installing /usr/local/share/perl5/Test2/Util/Times.pm
Installing /usr/local/share/perl5/Test2/Util/Term.pm
Installing /usr/local/share/perl5/Test2/Util/Grabber.pm
Installing /usr/local/share/perl5/Test2/Util/Table.pm
Installing /usr/local/share/perl5/Test2/Util/Table/LineBreak.pm
Installing /usr/local/share/perl5/Test2/Util/Table/Cell.pm
Installing /usr/local/share/perl5/Test2/Compare/DeepRef.pm
Installing /usr/local/share/perl5/Test2/Compare/Number.pm
Installing /usr/local/share/perl5/Test2/Compare/Ref.pm
Installing /usr/local/share/perl5/Test2/Compare/Pattern.pm
Installing /usr/local/share/perl5/Test2/Compare/Negatable.pm
Installing /usr/local/share/perl5/Test2/Compare/Set.pm
Installing /usr/local/share/perl5/Test2/Compare/Isa.pm
Installing /usr/local/share/perl5/Test2/Compare/EventMeta.pm
Installing /usr/local/share/perl5/Test2/Compare/Delta.pm
Installing /usr/local/share/perl5/Test2/Compare/Wildcard.pm
Installing /usr/local/share/perl5/Test2/Compare/Event.pm
Installing /usr/local/share/perl5/Test2/Compare/Custom.pm
Installing /usr/local/share/perl5/Test2/Compare/Float.pm
Installing /usr/local/share/perl5/Test2/Compare/Base.pm
Installing /usr/local/share/perl5/Test2/Compare/Undef.pm
Installing /usr/local/share/perl5/Test2/Compare/Hash.pm
Installing /usr/local/share/perl5/Test2/Compare/Meta.pm
Installing /usr/local/share/perl5/Test2/Compare/String.pm
Installing /usr/local/share/perl5/Test2/Compare/Regex.pm
Installing /usr/local/share/perl5/Test2/Compare/Array.pm
Installing /usr/local/share/perl5/Test2/Compare/Object.pm
Installing /usr/local/share/perl5/Test2/Compare/Scalar.pm
Installing /usr/local/share/perl5/Test2/Compare/Bag.pm
Installing /usr/local/share/perl5/Test2/Compare/Bool.pm
Installing /usr/local/share/perl5/Test2/Compare/OrderedSubset.pm
Installing /usr/local/share/perl5/Test2/Workflow/Runner.pm
Installing /usr/local/share/perl5/Test2/Workflow/BlockBase.pm
Installing /usr/local/share/perl5/Test2/Workflow/Build.pm
Installing /usr/local/share/perl5/Test2/Workflow/Task.pm
Installing /usr/local/share/perl5/Test2/Workflow/Task/Group.pm
Installing /usr/local/share/perl5/Test2/Workflow/Task/Action.pm
Installing /usr/local/share/perl5/Test2/AsyncSubtest/Hub.pm
Installing /usr/local/share/perl5/Test2/AsyncSubtest/Formatter.pm
Installing /usr/local/share/perl5/Test2/AsyncSubtest/Event/Detach.pm
Installing /usr/local/share/perl5/Test2/AsyncSubtest/Event/Attach.pm
Installing /usr/local/share/perl5/Test2/Manual/Tooling.pm
Installing /usr/local/share/perl5/Test2/Manual/Concurrency.pm
Installing /usr/local/share/perl5/Test2/Manual/Contributing.pm
Installing /usr/local/share/perl5/Test2/Manual/Testing.pm
Installing /usr/local/share/perl5/Test2/Manual/Anatomy.pm
Installing /usr/local/share/perl5/Test2/Manual/Tooling/FirstTool.pm
Installing /usr/local/share/perl5/Test2/Manual/Tooling/Formatter.pm
Installing /usr/local/share/perl5/Test2/Manual/Tooling/Testing.pm
Installing /usr/local/share/perl5/Test2/Manual/Tooling/Subtest.pm
Installing /usr/local/share/perl5/Test2/Manual/Tooling/Nesting.pm
Installing /usr/local/share/perl5/Test2/Manual/Tooling/TestBuilder.pm
Installing /usr/local/share/perl5/Test2/Manual/Tooling/Plugin/ToolStarts.pm
Installing /usr/local/share/perl5/Test2/Manual/Tooling/Plugin/TestingDone.pm
Installing /usr/local/share/perl5/Test2/Manual/Tooling/Plugin/ToolCompletes.pm
Installing /usr/local/share/perl5/Test2/Manual/Tooling/Plugin/TestExit.pm
Installing /usr/local/share/perl5/Test2/Manual/Anatomy/Context.pm
Installing /usr/local/share/perl5/Test2/Manual/Anatomy/Hubs.pm
Installing /usr/local/share/perl5/Test2/Manual/Anatomy/API.pm
Installing /usr/local/share/perl5/Test2/Manual/Anatomy/IPC.pm
Installing /usr/local/share/perl5/Test2/Manual/Anatomy/Event.pm
Installing /usr/local/share/perl5/Test2/Manual/Anatomy/EndToEnd.pm
Installing /usr/local/share/perl5/Test2/Manual/Anatomy/Utilities.pm
Installing /usr/local/share/perl5/Test2/Manual/Testing/Migrating.pm
Installing /usr/local/share/perl5/Test2/Manual/Testing/Todo.pm
Installing /usr/local/share/perl5/Test2/Manual/Testing/Introduction.pm
Installing /usr/local/share/perl5/Test2/Manual/Testing/Planning.pm
Installing /usr/local/share/perl5/Test2/Bundle/Simple.pm
Installing /usr/local/share/perl5/Test2/Bundle/Extended.pm
Installing /usr/local/share/perl5/Test2/Bundle/More.pm
Installing /usr/local/share/man/man3/Test2::Manual::Anatomy::EndToEnd.3pm
Installing /usr/local/share/man/man3/Test2::Require::AuthorTesting.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Ref.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Anatomy::API.3pm
Installing /usr/local/share/man/man3/Test2::AsyncSubtest.3pm
Installing /usr/local/share/man/man3/Test2::Tools::AsyncSubtest.3pm
Installing /usr/local/share/man/man3/Test2::Util::Stash.3pm
Installing /usr/local/share/man/man3/Test2::Require::Module.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Undef.3pm
Installing /usr/local/share/man/man3/Test2::Bundle::Extended.3pm
Installing /usr/local/share/man/man3/Test2::Require::RealFork.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Anatomy::IPC.3pm
Installing /usr/local/share/man/man3/Test2::Require::Threads.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Custom.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Base.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Set.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Testing::Planning.3pm
Installing /usr/local/share/man/man3/Test2::Tools.3pm
Installing /usr/local/share/man/man3/Test2::Suite.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Testing::Todo.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Tooling.3pm
Installing /usr/local/share/man/man3/Test2::Util::Table::LineBreak.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Exports.3pm
Installing /usr/local/share/man/man3/Test2::Plugin::Times.3pm
Installing /usr/local/share/man/man3/Test2::Util::Grabber.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Testing::Migrating.3pm
Installing /usr/local/share/man/man3/Test2::AsyncSubtest::Event::Detach.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Tooling::Subtest.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Tooling::TestBuilder.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Tooling::Plugin::ToolStarts.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Tester.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Class.3pm
Installing /usr/local/share/man/man3/Test2::V0.3pm
Installing /usr/local/share/man/man3/Test2::Require::EnvVar.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Negatable.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Warnings.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Tooling::Testing.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Spec.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Anatomy::Utilities.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Subtest.3pm
Installing /usr/local/share/man/man3/Test2::Plugin::SRand.3pm
Installing /usr/local/share/man/man3/Test2::Workflow::Task::Group.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Testing.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Number.3pm
Installing /usr/local/share/man/man3/Test2::Util::Times.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Wildcard.3pm
Installing /usr/local/share/man/man3/Test2::Compare::EventMeta.3pm
Installing /usr/local/share/man/man3/Test2::Todo.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Exception.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Event.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Scalar.3pm
Installing /usr/local/share/man/man3/Test2::Workflow::Task::Action.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Anatomy::Context.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Isa.3pm
Installing /usr/local/share/man/man3/Test2::Compare::OrderedSubset.3pm
Installing /usr/local/share/man/man3/Test2::AsyncSubtest::Event::Attach.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Float.3pm
Installing /usr/local/share/man/man3/Test2::Util::Ref.3pm
Installing /usr/local/share/man/man3/Test2::Workflow::Task.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Tooling::Plugin::ToolCompletes.3pm
Installing /usr/local/share/man/man3/Test2::Bundle::Simple.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Bag.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Event.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Pattern.3pm
Installing /usr/local/share/man/man3/Test2::Compare::String.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Ref.3pm
Installing /usr/local/share/man/man3/Test2::Bundle.3pm
Installing /usr/local/share/man/man3/Test2::Workflow.3pm
Installing /usr/local/share/man/man3/Test2::Workflow::Runner.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Contributing.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Anatomy.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Tooling::FirstTool.3pm
Installing /usr/local/share/man/man3/Test2::Plugin::ExitSummary.3pm
Installing /usr/local/share/man/man3/Test2::Workflow::Build.3pm
Installing /usr/local/share/man/man3/Test2::Tools::GenTemp.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Compare.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Bool.3pm
Installing /usr/local/share/man/man3/Test2::Plugin::UTF8.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Tooling::Plugin::TestingDone.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Anatomy::Event.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Tooling::Formatter.3pm
Installing /usr/local/share/man/man3/Test2::Mock.3pm
Installing /usr/local/share/man/man3/Test2::Workflow::BlockBase.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Meta.3pm
Installing /usr/local/share/man/man3/Test2::Util::Sub.3pm
Installing /usr/local/share/man/man3/Test2::Bundle::More.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Tooling::Nesting.3pm
Installing /usr/local/share/man/man3/Test2::Plugin::DieOnFail.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Encoding.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Basic.3pm
Installing /usr/local/share/man/man3/Test2::Plugin.3pm
Installing /usr/local/share/man/man3/Test2::Tools::ClassicCompare.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Testing::Introduction.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Target.3pm
Installing /usr/local/share/man/man3/Test2::Require::Fork.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Regex.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Tooling::Plugin::TestExit.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Object.3pm
Installing /usr/local/share/man/man3/Test2::Compare::DeepRef.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Mock.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Array.3pm
Installing /usr/local/share/man/man3/Test2::Plugin::BailOnFail.3pm
Installing /usr/local/share/man/man3/Test2::Manual.3pm
Installing /usr/local/share/man/man3/Test2::Require.3pm
Installing /usr/local/share/man/man3/Test2::Compare.3pm
Installing /usr/local/share/man/man3/Test2::AsyncSubtest::Hub.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Concurrency.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Grab.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Hash.3pm
Installing /usr/local/share/man/man3/Test2::Util::Table.3pm
Installing /usr/local/share/man/man3/Test2::Manual::Anatomy::Hubs.3pm
Installing /usr/local/share/man/man3/Test2::Tools::Defer.3pm
Installing /usr/local/share/man/man3/Test2::Compare::Delta.3pm
Installing /usr/local/share/man/man3/Test2::Require::Perl.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  EXODIST/Test2-Suite-0.000139.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'FFI::CheckLib'
Running make for P/PL/PLICEASE/FFI-CheckLib-0.27.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/P/PL/PLICEASE/FFI-CheckLib-0.27.tar.gz
Checksum for /root/.cpan/sources/authors/id/P/PL/PLICEASE/FFI-CheckLib-0.27.tar.gz ok
FFI-CheckLib-0.27/
FFI-CheckLib-0.27/t/
FFI-CheckLib-0.27/t/ffi_checklib__exit.t
FFI-CheckLib-0.27/t/ci.t
FFI-CheckLib-0.27/t/ffi_checklib__os_darwin.t
FFI-CheckLib-0.27/t/ffi_checklib__os_cygwin.t
FFI-CheckLib-0.27/t/ffi_checklib__os_unix.t
FFI-CheckLib-0.27/t/ffi_checklib.t
FFI-CheckLib-0.27/t/lib/
FFI-CheckLib-0.27/t/lib/Test2/
FFI-CheckLib-0.27/t/lib/Test2/Plugin/
FFI-CheckLib-0.27/t/lib/Test2/Plugin/FauxOS.pm
FFI-CheckLib-0.27/t/lib/Test2/Tools/
FFI-CheckLib-0.27/t/lib/Test2/Tools/FauxDynaLoader.pm
FFI-CheckLib-0.27/t/lib/Test2/Tools/NoteStderr.pm
FFI-CheckLib-0.27/t/00_diag.t
FFI-CheckLib-0.27/t/ffi_checklib__os_mswin32.t
FFI-CheckLib-0.27/t/ffi_checklib__os_msys.t
FFI-CheckLib-0.27/Changes
FFI-CheckLib-0.27/maint/
FFI-CheckLib-0.27/maint/cip-before-install
FFI-CheckLib-0.27/Makefile.PL
FFI-CheckLib-0.27/LICENSE
FFI-CheckLib-0.27/INSTALL
FFI-CheckLib-0.27/META.yml
FFI-CheckLib-0.27/META.json
FFI-CheckLib-0.27/author.yml
FFI-CheckLib-0.27/lib/
FFI-CheckLib-0.27/lib/FFI/
FFI-CheckLib-0.27/lib/FFI/CheckLib.pm
FFI-CheckLib-0.27/README
FFI-CheckLib-0.27/dist.ini
FFI-CheckLib-0.27/MANIFEST
FFI-CheckLib-0.27/example/
FFI-CheckLib-0.27/example/whichdll.pl
FFI-CheckLib-0.27/example/wheredll.pl
FFI-CheckLib-0.27/corpus/
FFI-CheckLib-0.27/corpus/darwin/
FFI-CheckLib-0.27/corpus/darwin/usr/
FFI-CheckLib-0.27/corpus/darwin/usr/lib/
FFI-CheckLib-0.27/corpus/darwin/usr/lib/libfoo.dylib.1
FFI-CheckLib-0.27/corpus/darwin/usr/lib/libfoo.a
FFI-CheckLib-0.27/corpus/darwin/usr/lib/libbar.dylib.1.2
FFI-CheckLib-0.27/corpus/darwin/usr/lib/libfoo.dylib.1.2
FFI-CheckLib-0.27/corpus/darwin/usr/lib/libbar.dylib.1.2.3
FFI-CheckLib-0.27/corpus/darwin/usr/lib/libfoo.dylib.1.2.3
FFI-CheckLib-0.27/corpus/darwin/usr/lib/libbar.dylib.1
FFI-CheckLib-0.27/corpus/darwin/usr/lib/libfoo.dylib
FFI-CheckLib-0.27/corpus/darwin/usr/lib/libbar.dylib
FFI-CheckLib-0.27/corpus/darwin/foo-1.00/
FFI-CheckLib-0.27/corpus/darwin/foo-1.00/src/
FFI-CheckLib-0.27/corpus/darwin/foo-1.00/src/libs/
FFI-CheckLib-0.27/corpus/darwin/foo-1.00/src/libs/libbaz.dylib
FFI-CheckLib-0.27/corpus/darwin/foo-1.00/src/libs/libfoo.dylib
FFI-CheckLib-0.27/corpus/darwin/foo-1.00/src/libs/libbar.dylib
FFI-CheckLib-0.27/corpus/darwin/custom/
FFI-CheckLib-0.27/corpus/darwin/custom/libfoo.dylib
FFI-CheckLib-0.27/corpus/darwin/lib/
FFI-CheckLib-0.27/corpus/darwin/lib/libfoo.dylib.2.3.4
FFI-CheckLib-0.27/corpus/darwin/lib/libfoo.dylib.2.3
FFI-CheckLib-0.27/corpus/darwin/lib/libfoo.dylib
FFI-CheckLib-0.27/corpus/darwin/lib/libfoo.dylib.2
FFI-CheckLib-0.27/corpus/lib/
FFI-CheckLib-0.27/corpus/lib/Alien/
FFI-CheckLib-0.27/corpus/lib/Alien/libbar.pm
FFI-CheckLib-0.27/corpus/generic.dll
FFI-CheckLib-0.27/corpus/unix/
FFI-CheckLib-0.27/corpus/unix/usr/
FFI-CheckLib-0.27/corpus/unix/usr/lib/
FFI-CheckLib-0.27/corpus/unix/usr/lib/libxor.so
FFI-CheckLib-0.27/corpus/unix/usr/lib/libxor.so.1.2.4
FFI-CheckLib-0.27/corpus/unix/usr/lib/libfoo.a
FFI-CheckLib-0.27/corpus/unix/usr/lib/libfoo.so.1
FFI-CheckLib-0.27/corpus/unix/usr/lib/libfoo.so.1.2
FFI-CheckLib-0.27/corpus/unix/usr/lib/libbar.so
FFI-CheckLib-0.27/corpus/unix/usr/lib/libcrypto.so.1.0.0
FFI-CheckLib-0.27/corpus/unix/usr/lib/libxor.so.1.2.3
FFI-CheckLib-0.27/corpus/unix/usr/lib/libcrypto.so.0.9.8
FFI-CheckLib-0.27/corpus/unix/usr/lib/libxor.so.1.2
FFI-CheckLib-0.27/corpus/unix/usr/lib/libbar.so.1
FFI-CheckLib-0.27/corpus/unix/usr/lib/libxor.so.1
FFI-CheckLib-0.27/corpus/unix/usr/lib/libfoo.so.1.2.3
FFI-CheckLib-0.27/corpus/unix/usr/lib/libbar.so.1.2
FFI-CheckLib-0.27/corpus/unix/usr/lib/libfoo.so
FFI-CheckLib-0.27/corpus/unix/usr/lib/libbar.so.1.2.3
FFI-CheckLib-0.27/corpus/unix/foo-1.00/
FFI-CheckLib-0.27/corpus/unix/foo-1.00/src/
FFI-CheckLib-0.27/corpus/unix/foo-1.00/src/libs/
FFI-CheckLib-0.27/corpus/unix/foo-1.00/src/libs/libbar.so
FFI-CheckLib-0.27/corpus/unix/foo-1.00/src/libs/libbaz.so
FFI-CheckLib-0.27/corpus/unix/foo-1.00/src/libs/libfoo.so
FFI-CheckLib-0.27/corpus/unix/custom/
FFI-CheckLib-0.27/corpus/unix/custom/libfoo.so
FFI-CheckLib-0.27/corpus/unix/lib/
FFI-CheckLib-0.27/corpus/unix/lib/libfoo.so.2
FFI-CheckLib-0.27/corpus/unix/lib/libfoo.so.2.3.4
FFI-CheckLib-0.27/corpus/unix/lib/libfoo.so.2.3
FFI-CheckLib-0.27/corpus/unix/lib/libfoo.so
FFI-CheckLib-0.27/corpus/cygwin/
FFI-CheckLib-0.27/corpus/cygwin/bin/
FFI-CheckLib-0.27/corpus/cygwin/bin/cygapatosaurus-0.dll
FFI-CheckLib-0.27/corpus/cygwin/bin/cygdinosaur.dll
FFI-CheckLib-0.27/corpus/windows/
FFI-CheckLib-0.27/corpus/windows/bin/
FFI-CheckLib-0.27/corpus/windows/bin/dinosaur.dll
FFI-CheckLib-0.27/corpus/windows/bin/dromornis_planei-3.0-7-0.dll
FFI-CheckLib-0.27/corpus/windows/bin/libthylacaleo_carnifex-3-7___.dll
FFI-CheckLib-0.27/corpus/windows/bin/libmaiasaura-3-7-0.dll
FFI-CheckLib-0.27/corpus/windows/bin/libapatosaurus-0.dll
FFI-CheckLib-0.27/corpus/windows/bincase/
FFI-CheckLib-0.27/corpus/windows/bincase/LIBbar.DLL
FFI-CheckLib-0.27/corpus/windows/bincase/foo.DLL
FFI-CheckLib-0.27/xt/
FFI-CheckLib-0.27/xt/author/
FFI-CheckLib-0.27/xt/author/pod.t
FFI-CheckLib-0.27/xt/author/version.t
FFI-CheckLib-0.27/xt/author/pod_spelling_system.t
FFI-CheckLib-0.27/xt/author/eol.t
FFI-CheckLib-0.27/xt/author/strict.t
FFI-CheckLib-0.27/xt/author/pod_spelling_common.t
FFI-CheckLib-0.27/xt/author/pod_coverage.t
FFI-CheckLib-0.27/xt/author/no_tabs.t
FFI-CheckLib-0.27/xt/release/
FFI-CheckLib-0.27/xt/release/changes.t
FFI-CheckLib-0.27/xt/release/fixme.t

  CPAN.pm: Building P/PL/PLICEASE/FFI-CheckLib-0.27.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for FFI::CheckLib
Writing MYMETA.yml and MYMETA.json
cp lib/FFI/CheckLib.pm blib/lib/FFI/CheckLib.pm
Manifying 1 pod document
  PLICEASE/FFI-CheckLib-0.27.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00_diag.t ................... 1/? #
#
#
# HARNESS_ACTIVE=1
# HARNESS_VERSION=3.17
# LANG=en_US.UTF-8
# PERL5LIB=/root/.cpan/build/FFI-CheckLib-0.27-NtHFa5/blib/lib:/root/.cpan/build/FFI-CheckLib-0.27-NtHFa5/blib/arch:
# PERL5OPT=
# PERL5_CPANPLUS_IS_RUNNING=27355
# PERL5_CPAN_IS_RUNNING=27355
# PERL_DL_NONLAZY=1
# SHELL=/bin/bash
#
#
#
# PERL5LIB path
# /root/.cpan/build/FFI-CheckLib-0.27-NtHFa5/blib/lib
# /root/.cpan/build/FFI-CheckLib-0.27-NtHFa5/blib/arch
#
#
#
# perl                   5.010001
# DynaLoader             1.10
# ExtUtils::MakeMaker    7.58
# FFI::Platypus          -
# Test2::API             1.302183
# Test2::Require::EnvVar 0.000139
# Test2::Require::Module 0.000139
# Test2::V0              0.000139
# Test::Exit             -
#
#
#
t/00_diag.t ................... ok
t/ci.t ........................ skipped: This test only runs if the $EXTRA_CI environment variable is set
t/ffi_checklib.t .............. ok
t/ffi_checklib__exit.t ........ skipped: Module 'Test::Exit' is not installed
t/ffi_checklib__os_cygwin.t ... ok
t/ffi_checklib__os_darwin.t ... ok
t/ffi_checklib__os_mswin32.t .. ok
t/ffi_checklib__os_msys.t ..... ok
t/ffi_checklib__os_unix.t ..... ok
All tests successful.
Files=9, Tests=64,  1 wallclock secs ( 0.05 usr  0.01 sys +  0.62 cusr  0.09 csys =  0.77 CPU)
Result: PASS
  PLICEASE/FFI-CheckLib-0.27.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/FFI-CheckLib-0.27-NtHFa5/blib/arch /root/.cpan/build/FFI-CheckLib-0.27-NtHFa5/blib/lib to PERL5LIB for 'install'
Manifying 1 pod document
Installing /usr/local/share/perl5/FFI/CheckLib.pm
Installing /usr/local/share/man/man3/FFI::CheckLib.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  PLICEASE/FFI-CheckLib-0.27.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'Path::Tiny'
Running make for D/DA/DAGOLDEN/Path-Tiny-0.114.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/D/DA/DAGOLDEN/Path-Tiny-0.114.tar.gz
Checksum for /root/.cpan/sources/authors/id/D/DA/DAGOLDEN/Path-Tiny-0.114.tar.gz ok
Path-Tiny-0.114/
Path-Tiny-0.114/LICENSE
Path-Tiny-0.114/cpanfile
Path-Tiny-0.114/Changes
Path-Tiny-0.114/MANIFEST
Path-Tiny-0.114/perlcritic.rc
Path-Tiny-0.114/CONTRIBUTING.mkdn
Path-Tiny-0.114/t/
Path-Tiny-0.114/xt/
Path-Tiny-0.114/README
Path-Tiny-0.114/META.yml
Path-Tiny-0.114/tidyall.ini
Path-Tiny-0.114/lib/
Path-Tiny-0.114/Makefile.PL
Path-Tiny-0.114/META.json
Path-Tiny-0.114/dist.ini
Path-Tiny-0.114/lib/Path/
Path-Tiny-0.114/lib/Path/Tiny.pm
Path-Tiny-0.114/xt/author/
Path-Tiny-0.114/xt/release/
Path-Tiny-0.114/xt/release/distmeta.t
Path-Tiny-0.114/xt/author/critic.t
Path-Tiny-0.114/xt/author/minimum-version.t
Path-Tiny-0.114/xt/author/test-version.t
Path-Tiny-0.114/xt/author/00-compile.t
Path-Tiny-0.114/xt/author/pod-syntax.t
Path-Tiny-0.114/xt/author/portability.t
Path-Tiny-0.114/xt/author/pod-spell.t
Path-Tiny-0.114/xt/author/pod-coverage.t
Path-Tiny-0.114/t/filesystem.t
Path-Tiny-0.114/t/exports.t
Path-Tiny-0.114/t/sig_die.t
Path-Tiny-0.114/t/chmod.t
Path-Tiny-0.114/t/zz-atomic.t
Path-Tiny-0.114/t/input_output.t
Path-Tiny-0.114/t/visit.t
Path-Tiny-0.114/t/recurse.t
Path-Tiny-0.114/t/digest.t
Path-Tiny-0.114/t/mutable_tree_while_iterating.t
Path-Tiny-0.114/t/locking.t
Path-Tiny-0.114/t/normalize.t
Path-Tiny-0.114/t/overloading.t
Path-Tiny-0.114/t/symlinks.t
Path-Tiny-0.114/t/children.t
Path-Tiny-0.114/t/README
Path-Tiny-0.114/t/temp.t
Path-Tiny-0.114/t/basic.t
Path-Tiny-0.114/t/zzz-spec.t
Path-Tiny-0.114/t/mkpath.t
Path-Tiny-0.114/t/rel-abs.t
Path-Tiny-0.114/t/parent.t
Path-Tiny-0.114/t/00-report-prereqs.t
Path-Tiny-0.114/t/lib/
Path-Tiny-0.114/t/input_output_no_PU_UU.t
Path-Tiny-0.114/t/00-report-prereqs.dd
Path-Tiny-0.114/t/exception.t
Path-Tiny-0.114/t/data/
Path-Tiny-0.114/t/input_output_no_UU.t
Path-Tiny-0.114/t/basename.t
Path-Tiny-0.114/t/fakelib/
Path-Tiny-0.114/t/subsumes.t
Path-Tiny-0.114/t/fakelib/Unicode/
Path-Tiny-0.114/t/fakelib/PerlIO/
Path-Tiny-0.114/t/fakelib/PerlIO/utf8_strict.pm
Path-Tiny-0.114/t/fakelib/Unicode/UTF8.pm
Path-Tiny-0.114/t/data/chmod.txt
Path-Tiny-0.114/t/lib/TestUtils.pm

  CPAN.pm: Building D/DA/DAGOLDEN/Path-Tiny-0.114.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for Path::Tiny
Writing MYMETA.yml and MYMETA.json
cp lib/Path/Tiny.pm blib/lib/Path/Tiny.pm
Manifying 1 pod document
  DAGOLDEN/Path-Tiny-0.114.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00-report-prereqs.t ............. #
# Versions for all modules listed in MYMETA.json (including optional ones):
#
# === Configure Requires ===
#
#     Module              Want Have
#     ------------------- ---- ----
#     ExtUtils::MakeMaker 6.17 7.58
#
# === Configure Suggests ===
#
#     Module      Want    Have
#     -------- ------- -------
#     JSON::PP 2.27300 2.27203
#
# === Build Requires ===
#
#     Module              Want Have
#     ------------------- ---- ----
#     ExtUtils::MakeMaker  any 7.58
#
# === Test Requires ===
#
#     Module                Want     Have
#     --------------------- ---- --------
#     Digest::MD5            any     2.39
#     ExtUtils::MakeMaker    any     7.58
#     File::Basename         any     2.77
#     File::Spec            0.86     3.30
#     File::Spec::Functions  any     3.30
#     File::Spec::Unix       any     3.30
#     File::Temp            0.19     0.22
#     Test::More            0.96 1.302183
#     lib                    any     0.62
#     open                   any     1.07
#
# === Test Recommends ===
#
#     Module                 Want     Have
#     ------------------ -------- --------
#     CPAN::Meta         2.120900 2.143240
#     Test::FailWarnings      any  missing
#     Test::MockRandom        any  missing
#
# === Runtime Requires ===
#
#     Module             Want Have
#     ------------------ ---- ----
#     Carp                any 1.11
#     Cwd                 any 3.30
#     Digest             1.03 1.16
#     Digest::SHA        5.45 5.47
#     Encode              any 2.35
#     Exporter           5.57 5.63
#     Fcntl               any 1.06
#     File::Copy          any 2.14
#     File::Glob          any 1.06
#     File::Path         2.07 2.08
#     File::Spec         0.86 3.30
#     File::Temp         0.19 0.22
#     File::stat          any 1.01
#     constant            any 1.17
#     overload            any 1.07
#     strict              any 1.04
#     warnings            any 1.06
#     warnings::register  any 1.01
#
# === Runtime Recommends ===
#
#     Module        Want    Have
#     ------------- ---- -------
#     Unicode::UTF8 0.58 missing
#
t/00-report-prereqs.t ............. ok
t/basename.t ...................... ok
t/basic.t ......................... ok
t/children.t ...................... ok
t/chmod.t ......................... ok
t/digest.t ........................ ok
t/exception.t ..................... ok
t/exports.t ....................... ok
t/filesystem.t .................... ok
t/input_output.t .................. ok
t/input_output_no_PU_UU.t ......... ok
t/input_output_no_UU.t ............ ok
t/locking.t ....................... ok
t/mkpath.t ........................ ok
t/mutable_tree_while_iterating.t .. ok
t/normalize.t ..................... ok
t/overloading.t ................... ok
t/parent.t ........................ ok
t/recurse.t ....................... ok
t/rel-abs.t ....................... ok
t/sig_die.t ....................... ok
t/subsumes.t ...................... ok
t/symlinks.t ...................... ok
t/temp.t .......................... ok
t/visit.t ......................... ok
t/zz-atomic.t ..................... skipped: Test::MockRandom required for atomicity tests
t/zzz-spec.t ...................... ok
All tests successful.
Files=27, Tests=1704,  3 wallclock secs ( 0.25 usr  0.05 sys +  1.96 cusr  0.28 csys =  2.54 CPU)
Result: PASS
  DAGOLDEN/Path-Tiny-0.114.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/Path-Tiny-0.114-RaTt1X/blib/arch /root/.cpan/build/Path-Tiny-0.114-RaTt1X/blib/lib to PERL5LIB for 'install'
Manifying 1 pod document
Installing /usr/local/share/perl5/Path/Tiny.pm
Installing /usr/local/share/man/man3/Path::Tiny.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  DAGOLDEN/Path-Tiny-0.114.tar.gz
  /usr/bin/make install  -- OK
Running make for P/PL/PLICEASE/Alien-Build-2.37.tar.gz
  Has already been unwrapped into directory /root/.cpan/build/Alien-Build-2.37-izR6En

  CPAN.pm: Building P/PL/PLICEASE/Alien-Build-2.37.tar.gz

cp lib/Alien/Build/Log.pm blib/lib/Alien/Build/Log.pm
cp lib/Alien/Build/Plugin/Core/CleanInstall.pm blib/lib/Alien/Build/Plugin/Core/CleanInstall.pm
cp lib/Alien/Build/Plugin/Core/Gather.pm blib/lib/Alien/Build/Plugin/Core/Gather.pm
cp lib/Alien/Build/Manual/PluginAuthor.pod blib/lib/Alien/Build/Manual/PluginAuthor.pod
cp lib/Alien/Build/CommandSequence.pm blib/lib/Alien/Build/CommandSequence.pm
cp lib/Alien/Build/Plugin/Build/Autoconf.pm blib/lib/Alien/Build/Plugin/Build/Autoconf.pm
cp lib/Alien/Build/Plugin/Build.pod blib/lib/Alien/Build/Plugin/Build.pod
cp lib/Alien/Base/Authoring.pod blib/lib/Alien/Base/Authoring.pod
cp lib/Alien/Build/Plugin/Core/Legacy.pm blib/lib/Alien/Build/Plugin/Core/Legacy.pm
cp lib/Alien/Base.pm blib/lib/Alien/Base.pm
cp lib/Alien/Build/Manual/FAQ.pod blib/lib/Alien/Build/Manual/FAQ.pod
cp lib/Alien/Build/MM.pm blib/lib/Alien/Build/MM.pm
cp lib/Alien/Base/FAQ.pod blib/lib/Alien/Base/FAQ.pod
cp lib/Alien/Build/Manual/AlienAuthor.pod blib/lib/Alien/Build/Manual/AlienAuthor.pod
cp lib/Alien/Build/Plugin/Core.pod blib/lib/Alien/Build/Plugin/Core.pod
cp lib/Alien/Base/PkgConfig.pm blib/lib/Alien/Base/PkgConfig.pm
cp lib/Alien/Build/Plugin/Build/CMake.pm blib/lib/Alien/Build/Plugin/Build/CMake.pm
cp lib/Alien/Build/Manual/Contributing.pod blib/lib/Alien/Build/Manual/Contributing.pod
cp lib/Alien/Build/Plugin/Build/MSYS.pm blib/lib/Alien/Build/Plugin/Build/MSYS.pm
cp lib/Alien/Build/Manual/AlienUser.pod blib/lib/Alien/Build/Manual/AlienUser.pod
cp lib/Alien/Build.pm blib/lib/Alien/Build.pm
cp lib/Alien/Build/Log/Abbreviate.pm blib/lib/Alien/Build/Log/Abbreviate.pm
cp lib/Alien/Build/Plugin/Build/SearchDep.pm blib/lib/Alien/Build/Plugin/Build/SearchDep.pm
cp lib/Alien/Build/Plugin/Core/FFI.pm blib/lib/Alien/Build/Plugin/Core/FFI.pm
cp lib/Alien/Build/Plugin/Core/Download.pm blib/lib/Alien/Build/Plugin/Core/Download.pm
cp lib/Alien/Build/Plugin/Build/Make.pm blib/lib/Alien/Build/Plugin/Build/Make.pm
cp lib/Alien/Base/Wrapper.pm blib/lib/Alien/Base/Wrapper.pm
cp lib/Alien/Build/Manual/Alien.pod blib/lib/Alien/Build/Manual/Alien.pod
cp lib/Alien/Build/Interpolate/Default.pm blib/lib/Alien/Build/Interpolate/Default.pm
cp lib/Alien/Build/Plugin.pm blib/lib/Alien/Build/Plugin.pm
cp lib/Alien/Build/Plugin/Build/Copy.pm blib/lib/Alien/Build/Plugin/Build/Copy.pm
cp lib/Alien/Build/Log/Default.pm blib/lib/Alien/Build/Log/Default.pm
cp lib/Alien/Build/Interpolate.pm blib/lib/Alien/Build/Interpolate.pm
cp lib/Alien/Build/Plugin/Fetch/Wget.pm blib/lib/Alien/Build/Plugin/Fetch/Wget.pm
cp lib/Alien/Build/Plugin/Decode/HTML.pm blib/lib/Alien/Build/Plugin/Decode/HTML.pm
cp lib/Alien/Build/Plugin/Fetch/LocalDir.pm blib/lib/Alien/Build/Plugin/Fetch/LocalDir.pm
cp lib/Alien/Build/Plugin/Download.pod blib/lib/Alien/Build/Plugin/Download.pod
cp lib/Alien/Build/Plugin/Fetch/HTTPTiny.pm blib/lib/Alien/Build/Plugin/Fetch/HTTPTiny.pm
cp lib/Alien/Build/Plugin/Decode/Mojo.pm blib/lib/Alien/Build/Plugin/Decode/Mojo.pm
cp lib/Alien/Build/Plugin/Gather/IsolateDynamic.pm blib/lib/Alien/Build/Plugin/Gather/IsolateDynamic.pm
cp lib/Alien/Build/Plugin/Extract.pod blib/lib/Alien/Build/Plugin/Extract.pod
cp lib/Alien/Build/Plugin/Download/Negotiate.pm blib/lib/Alien/Build/Plugin/Download/Negotiate.pm
cp lib/Alien/Build/Plugin/Fetch/Local.pm blib/lib/Alien/Build/Plugin/Fetch/Local.pm
cp lib/Alien/Build/Plugin/Fetch/LWP.pm blib/lib/Alien/Build/Plugin/Fetch/LWP.pm
cp lib/Alien/Build/Plugin/Extract/ArchiveZip.pm blib/lib/Alien/Build/Plugin/Extract/ArchiveZip.pm
cp lib/Alien/Build/Plugin/Fetch/CurlCommand.pm blib/lib/Alien/Build/Plugin/Fetch/CurlCommand.pm
cp lib/Alien/Build/Plugin/Core/Override.pm blib/lib/Alien/Build/Plugin/Core/Override.pm
cp lib/Alien/Build/Plugin/Core/Setup.pm blib/lib/Alien/Build/Plugin/Core/Setup.pm
cp lib/Alien/Build/Plugin/PkgConfig/CommandLine.pm blib/lib/Alien/Build/Plugin/PkgConfig/CommandLine.pm
cp lib/Alien/Build/Plugin/Extract/ArchiveTar.pm blib/lib/Alien/Build/Plugin/Extract/ArchiveTar.pm
cp lib/Alien/Build/Plugin/Extract/Directory.pm blib/lib/Alien/Build/Plugin/Extract/Directory.pm
cp lib/Alien/Build/Plugin/Decode.pod blib/lib/Alien/Build/Plugin/Decode.pod
cp lib/Alien/Build/Plugin/PkgConfig/LibPkgConf.pm blib/lib/Alien/Build/Plugin/PkgConfig/LibPkgConf.pm
cp lib/Alien/Build/Plugin/Fetch/NetFTP.pm blib/lib/Alien/Build/Plugin/Fetch/NetFTP.pm
cp lib/Alien/Build/Plugin/Decode/DirListing.pm blib/lib/Alien/Build/Plugin/Decode/DirListing.pm
cp lib/Alien/Build/Plugin/Core/Tail.pm blib/lib/Alien/Build/Plugin/Core/Tail.pm
cp lib/Alien/Build/Plugin/Fetch.pod blib/lib/Alien/Build/Plugin/Fetch.pod
cp lib/Alien/Build/Plugin/Extract/CommandLine.pm blib/lib/Alien/Build/Plugin/Extract/CommandLine.pm
cp lib/Alien/Build/Plugin/Extract/Negotiate.pm blib/lib/Alien/Build/Plugin/Extract/Negotiate.pm
cp lib/Alien/Build/Plugin/Decode/DirListingFtpcopy.pm blib/lib/Alien/Build/Plugin/Decode/DirListingFtpcopy.pm
cp lib/Alien/Build/Plugin/PkgConfig/Negotiate.pm blib/lib/Alien/Build/Plugin/PkgConfig/Negotiate.pm
cp lib/Alien/Build/Plugin/Probe.pod blib/lib/Alien/Build/Plugin/Probe.pod
cp lib/Alien/Build/Plugin/Prefer/SortVersions.pm blib/lib/Alien/Build/Plugin/Prefer/SortVersions.pm
cp lib/Alien/Build/Plugin/PkgConfig/PP.pm blib/lib/Alien/Build/Plugin/PkgConfig/PP.pm
cp lib/Alien/Build/Plugin/Probe/Vcpkg.pm blib/lib/Alien/Build/Plugin/Probe/Vcpkg.pm
cp lib/Alien/Build/Version/Basic.pm blib/lib/Alien/Build/Version/Basic.pm
cp lib/Test/Alien.pm blib/lib/Test/Alien.pm
cp lib/Alien/Build/Util.pm blib/lib/Alien/Build/Util.pm
cp lib/Alien/Build/Plugin/PkgConfig/MakeStatic.pm blib/lib/Alien/Build/Plugin/PkgConfig/MakeStatic.pm
cp lib/Test/Alien/CanPlatypus.pm blib/lib/Test/Alien/CanPlatypus.pm
cp lib/Test/Alien/Build.pm blib/lib/Test/Alien/Build.pm
cp lib/Alien/Build/Plugin/Test/Mock.pm blib/lib/Alien/Build/Plugin/Test/Mock.pm
cp lib/Test/Alien/Synthetic.pm blib/lib/Test/Alien/Synthetic.pm
cp lib/Test/Alien/Run.pm blib/lib/Test/Alien/Run.pm
cp lib/Alien/Build/Plugin/Probe/CommandLine.pm blib/lib/Alien/Build/Plugin/Probe/CommandLine.pm
cp lib/Alien/Build/rc.pm blib/lib/Alien/Build/rc.pm
cp lib/Alien/Build/Plugin/Prefer/BadVersion.pm blib/lib/Alien/Build/Plugin/Prefer/BadVersion.pm
cp lib/Alien/Role.pm blib/lib/Alien/Role.pm
cp lib/Alien/Build/Plugin/Prefer/GoodVersion.pm blib/lib/Alien/Build/Plugin/Prefer/GoodVersion.pm
cp lib/Alien/Build/Plugin/Prefer.pod blib/lib/Alien/Build/Plugin/Prefer.pod
cp lib/Alien/Build/Temp.pm blib/lib/Alien/Build/Temp.pm
cp lib/Test/Alien/CanCompile.pm blib/lib/Test/Alien/CanCompile.pm
cp lib/Alien/Build/Plugin/Probe/CBuilder.pm blib/lib/Alien/Build/Plugin/Probe/CBuilder.pm
cp lib/alienfile.pm blib/lib/alienfile.pm
cp lib/Test/Alien/Diag.pm blib/lib/Test/Alien/Diag.pm
Manifying 30 pod documents
Manifying 26 pod documents
Manifying 29 pod documents
  PLICEASE/Alien-Build-2.37.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00_diag.t .......................................... 1/? #
#
#
# HARNESS_ACTIVE=1
# HARNESS_VERSION=3.17
# LANG=en_US.UTF-8
# PERL5LIB=/root/.cpan/build/Alien-Build-2.37-izR6En/blib/lib:/root/.cpan/build/Alien-Build-2.37-izR6En/blib/arch:
# PERL5OPT=
# PERL5_CPANPLUS_IS_RUNNING=27355
# PERL5_CPAN_IS_RUNNING=27355
# PERL_DL_NONLAZY=1
# SHELL=/bin/bash
#
#
#
# PERL5LIB path
# /root/.cpan/build/Alien-Build-2.37-izR6En/blib/lib
# /root/.cpan/build/Alien-Build-2.37-izR6En/blib/arch
#
#
#
# perl                     5.010001 linux x86_64-linux-thread-multi
# Acme::Alien::DontPanic   -
# Alien::Base::ModuleBuild -
# Alien::Libbz2            -
# Alien::cmake3            -
# Alien::gzip              -
# Alien::xz                -
# Archive::Tar             1.58
# Archive::Zip             -
# Capture::Tiny            0.48
# Devel::Hide              -
# Digest::SHA              5.47
# Env::ShellWords          -
# ExtUtils::CBuilder       0.27
# ExtUtils::MakeMaker      7.58
# ExtUtils::ParseXS        3.35
# FFI::CheckLib            0.27
# FFI::Platypus            -
# File::Listing            6.04
# File::Listing::Ftpcopy   -
# File::Which              1.23
# File::chdir              0.1010
# HTML::Parser             3.64
# HTTP::Tiny               -
# IO::Compress::Bzip2      2.049
# IO::Socket::SSL          1.31
# IO::Uncompress::Bunzip2  2.049
# IO::Zlib                 1.09
# JSON::PP                 2.27203
# LWP                      6.04
# LWP::Protocol::https     undef
# List::Util               1.55
# Mojo::DOM58              -
# Mojolicious              -
# Net::FTP                 2.77
# Net::SSLeay              1.35
# Path::Tiny               0.114
# PkgConfig                -
# PkgConfig::LibPkgConf    -
# Readonly                 -
# Sort::Versions           -
# Test2::API               1.302183
# Test2::V0                0.000139
# Text::ParseWords         3.27
# URI                      1.37
# YAML                     -
#
#
#
# $VAR1 = {
#           'system_type' => 'unix',
#           'pkg-config' => {
#                             'pkgconf' => undef,
#                             'pkg-config' => '/usr/bin/pkg-config'
#                           },
#           'compiler_type' => 'unix',
#           'cmake_generator' => 'Unix Makefiles'
#         };
# pkg-config negotiate pick = PkgConfig::CommandLine
#
#
# [config.site]
# # file automatically generated by /root/.cpan/build/Alien-Build-2.37-izR6En/blib/lib/Alien/Build/Plugin/Build/Autoconf.pm
# libdir='${prefix}/lib'
#
#
#
t/00_diag.t .......................................... ok
t/01_use.t ........................................... ok
t/alien_base.t ....................................... ok
t/alien_base__system_installed.t ..................... skipped: test requires Alien::Base::ModuleBuild
t/alien_base_pkgconfig.t ............................. ok
t/alien_base_wrapper.t ............................... ok
t/alien_build.t ...................................... ok
t/alien_build_commandsequence.t ...................... ok
t/alien_build_commandsequence__cd.t .................. ok
t/alien_build_interpolate.t .......................... ok
t/alien_build_interpolate_default.t .................. ok
t/alien_build_log.t .................................. ok
t/alien_build_log_abbreviate.t ....................... ok
t/alien_build_log_default.t .......................... ok
t/alien_build_meta.t ................................. ok
t/alien_build_mm.t ................................... ok
t/alien_build_plugin.t ............................... ok
t/alien_build_plugin_build_autoconf.t ................ ok
t/alien_build_plugin_build_cmake.t ................... skipped: test requires Alien::cmake3
t/alien_build_plugin_build_copy.t .................... ok
t/alien_build_plugin_build_make.t .................... ok
t/alien_build_plugin_build_msys.t .................... ok
t/alien_build_plugin_build_searchdep.t ............... skipped: test requires Env::ShellWords
t/alien_build_plugin_core_cleaninstall.t ............. ok
t/alien_build_plugin_core_download.t ................. ok
t/alien_build_plugin_core_ffi.t ...................... ok
t/alien_build_plugin_core_gather.t ................... ok
t/alien_build_plugin_core_legacy.t ................... ok
t/alien_build_plugin_core_override.t ................. ok
t/alien_build_plugin_core_setup.t .................... ok
t/alien_build_plugin_core_tail.t ..................... ok
t/alien_build_plugin_decode_dirlisting.t ............. ok
t/alien_build_plugin_decode_dirlistingftpcopy.t ...... ok
t/alien_build_plugin_decode_html.t ................... ok
t/alien_build_plugin_decode_mojo.t ................... ok
t/alien_build_plugin_download_negotiate.t ............ ok
t/alien_build_plugin_extract_archivetar.t ............ ok
t/alien_build_plugin_extract_archivezip.t ............ ok
t/alien_build_plugin_extract_commandline.t ........... ok
t/alien_build_plugin_extract_commandline__tar_can.t .. skipped: test requires Readonly 1.60
t/alien_build_plugin_extract_directory.t ............. ok
t/alien_build_plugin_extract_negotiate.t ............. ok
t/alien_build_plugin_fetch_curlcommand.t ............. ok
t/alien_build_plugin_fetch_httptiny.t ................ ok
t/alien_build_plugin_fetch_local.t ................... ok
t/alien_build_plugin_fetch_localdir.t ................ ok
t/alien_build_plugin_fetch_lwp.t ..................... ok
t/alien_build_plugin_fetch_netftp.t .................. ok
t/alien_build_plugin_fetch_wget.t .................... ok
t/alien_build_plugin_gather_isolatedynamic.t ......... ok
t/alien_build_plugin_meta.t .......................... ok
t/alien_build_plugin_pkgconfig_commandline.t ......... ok
t/alien_build_plugin_pkgconfig_libpkgconf.t .......... skipped: Test requires PkgConfig::LibPkgConf
t/alien_build_plugin_pkgconfig_makestatic.t .......... skipped: test requires PkgConfig.pm
t/alien_build_plugin_pkgconfig_negotiate.t ........... ok
t/alien_build_plugin_pkgconfig_negotiate__pick.t ..... ok
t/alien_build_plugin_pkgconfig_pp.t .................. skipped: test requires PkgConfig 0.14026
t/alien_build_plugin_prefer_badversion.t ............. skipped: test requires Sort::Versions
t/alien_build_plugin_prefer_goodversion.t ............ skipped: test requires Sort::Versions
t/alien_build_plugin_prefer_sortversions.t ........... ok
t/alien_build_plugin_probe_cbuilder.t ................ ok
t/alien_build_plugin_probe_cbuilder__live.t .......... skipped: CI only
t/alien_build_plugin_probe_commandline.t ............. ok
t/alien_build_plugin_probe_vcpkg.t ................... skipped: Test requires Win32::Vcpkg 0.02
t/alien_build_plugin_test_mock.t ..................... ok
t/alien_build_rc.t ................................... ok
t/alien_build_temp.t ................................. ok
t/alien_build_tempdir.t .............................. ok
t/alien_build_util.t ................................. ok
t/alien_build_version_basic.t ........................ ok
t/alien_role.t ....................................... ok
t/alienfile.t ........................................ ok
t/test_alien.t ....................................... ok
t/test_alien_build.t ................................. ok
t/test_alien_cancompile.t ............................ ok
t/test_alien_canplatypus.t ........................... ok
t/test_alien_diag.t .................................. ok
t/test_alien_run.t ................................... ok
t/test_alien_synthetic.t ............................. ok
All tests successful.
Files=79, Tests=390, 13 wallclock secs ( 0.30 usr  0.11 sys +  9.93 cusr  1.88 csys = 12.22 CPU)
Result: PASS
  PLICEASE/Alien-Build-2.37.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/Alien-Build-2.37-izR6En/blib/arch /root/.cpan/build/Alien-Build-2.37-izR6En/blib/lib to PERL5LIB for 'install'
Manifying 30 pod documents
Manifying 26 pod documents
Manifying 29 pod documents
Installing /usr/local/share/perl5/alienfile.pm
Installing /usr/local/share/perl5/Alien/Base.pm
Installing /usr/local/share/perl5/Alien/Build.pm
Installing /usr/local/share/perl5/Alien/Role.pm
Installing /usr/local/share/perl5/Alien/Build/CommandSequence.pm
Installing /usr/local/share/perl5/Alien/Build/Temp.pm
Installing /usr/local/share/perl5/Alien/Build/Log.pm
Installing /usr/local/share/perl5/Alien/Build/Interpolate.pm
Installing /usr/local/share/perl5/Alien/Build/Util.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin.pm
Installing /usr/local/share/perl5/Alien/Build/MM.pm
Installing /usr/local/share/perl5/Alien/Build/rc.pm
Installing /usr/local/share/perl5/Alien/Build/Log/Default.pm
Installing /usr/local/share/perl5/Alien/Build/Log/Abbreviate.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Extract.pod
Installing /usr/local/share/perl5/Alien/Build/Plugin/Decode.pod
Installing /usr/local/share/perl5/Alien/Build/Plugin/Core.pod
Installing /usr/local/share/perl5/Alien/Build/Plugin/Download.pod
Installing /usr/local/share/perl5/Alien/Build/Plugin/Build.pod
Installing /usr/local/share/perl5/Alien/Build/Plugin/Prefer.pod
Installing /usr/local/share/perl5/Alien/Build/Plugin/Fetch.pod
Installing /usr/local/share/perl5/Alien/Build/Plugin/Probe.pod
Installing /usr/local/share/perl5/Alien/Build/Plugin/Extract/Negotiate.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Extract/ArchiveTar.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Extract/Directory.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Extract/CommandLine.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Extract/ArchiveZip.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Gather/IsolateDynamic.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Build/CMake.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Build/Copy.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Build/Autoconf.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Build/MSYS.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Build/SearchDep.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Build/Make.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Prefer/GoodVersion.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Prefer/BadVersion.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Prefer/SortVersions.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Test/Mock.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Decode/DirListingFtpcopy.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Decode/HTML.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Decode/DirListing.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Decode/Mojo.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Fetch/CurlCommand.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Fetch/LocalDir.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Fetch/Local.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Fetch/Wget.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Fetch/LWP.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Fetch/NetFTP.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Fetch/HTTPTiny.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Download/Negotiate.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/PkgConfig/LibPkgConf.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/PkgConfig/MakeStatic.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/PkgConfig/Negotiate.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/PkgConfig/PP.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/PkgConfig/CommandLine.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Probe/Vcpkg.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Probe/CommandLine.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Probe/CBuilder.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Core/Tail.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Core/FFI.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Core/Legacy.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Core/Gather.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Core/Override.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Core/Download.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Core/Setup.pm
Installing /usr/local/share/perl5/Alien/Build/Plugin/Core/CleanInstall.pm
Installing /usr/local/share/perl5/Alien/Build/Version/Basic.pm
Installing /usr/local/share/perl5/Alien/Build/Interpolate/Default.pm
Installing /usr/local/share/perl5/Alien/Build/Manual/AlienUser.pod
Installing /usr/local/share/perl5/Alien/Build/Manual/PluginAuthor.pod
Installing /usr/local/share/perl5/Alien/Build/Manual/Contributing.pod
Installing /usr/local/share/perl5/Alien/Build/Manual/Alien.pod
Installing /usr/local/share/perl5/Alien/Build/Manual/AlienAuthor.pod
Installing /usr/local/share/perl5/Alien/Build/Manual/FAQ.pod
Installing /usr/local/share/perl5/Alien/Base/Authoring.pod
Installing /usr/local/share/perl5/Alien/Base/Wrapper.pm
Installing /usr/local/share/perl5/Alien/Base/PkgConfig.pm
Installing /usr/local/share/perl5/Alien/Base/FAQ.pod
Installing /usr/local/share/perl5/Test/Alien.pm
Installing /usr/local/share/perl5/Test/Alien/Synthetic.pm
Installing /usr/local/share/perl5/Test/Alien/Run.pm
Installing /usr/local/share/perl5/Test/Alien/CanCompile.pm
Installing /usr/local/share/perl5/Test/Alien/CanPlatypus.pm
Installing /usr/local/share/perl5/Test/Alien/Build.pm
Installing /usr/local/share/perl5/Test/Alien/Diag.pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Extract::CommandLine.3pm
Installing /usr/local/share/man/man3/Alien::Build::rc.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Download::Negotiate.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Decode.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Extract::ArchiveZip.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Build::CMake.3pm
Installing /usr/local/share/man/man3/Alien::Build::Manual::AlienUser.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Core::FFI.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Fetch::HTTPTiny.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Extract::Directory.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Core::Download.3pm
Installing /usr/local/share/man/man3/Alien::Build::Log::Abbreviate.3pm
Installing /usr/local/share/man/man3/Alien::Build::Interpolate.3pm
Installing /usr/local/share/man/man3/Test::Alien::CanCompile.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Build::Autoconf.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Extract::ArchiveTar.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::PkgConfig::MakeStatic.3pm
Installing /usr/local/share/man/man3/Alien::Build::Manual::FAQ.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Fetch::Wget.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Core::Setup.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Fetch::CurlCommand.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Build::Copy.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Prefer::SortVersions.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Core::Override.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Core.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Fetch::NetFTP.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Probe::Vcpkg.3pm
Installing /usr/local/share/man/man3/Test::Alien::Synthetic.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Core::CleanInstall.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Download.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Test::Mock.3pm
Installing /usr/local/share/man/man3/Alien::Build::Manual::Contributing.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Decode::HTML.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::PkgConfig::Negotiate.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Fetch.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::PkgConfig::CommandLine.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Fetch::LWP.3pm
Installing /usr/local/share/man/man3/Alien::Build::Manual::PluginAuthor.3pm
Installing /usr/local/share/man/man3/alienfile.3pm
Installing /usr/local/share/man/man3/Alien::Build::Util.3pm
Installing /usr/local/share/man/man3/Alien::Build::Interpolate::Default.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Prefer::BadVersion.3pm
Installing /usr/local/share/man/man3/Alien::Base::FAQ.3pm
Installing /usr/local/share/man/man3/Alien::Build::CommandSequence.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Probe::CBuilder.3pm
Installing /usr/local/share/man/man3/Alien::Build::Log.3pm
Installing /usr/local/share/man/man3/Alien::Build::Manual::Alien.3pm
Installing /usr/local/share/man/man3/Alien::Build::Temp.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Extract.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Fetch::LocalDir.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Decode::DirListing.3pm
Installing /usr/local/share/man/man3/Alien::Base::Wrapper.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Build::MSYS.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Gather::IsolateDynamic.3pm
Installing /usr/local/share/man/man3/Test::Alien::CanPlatypus.3pm
Installing /usr/local/share/man/man3/Test::Alien::Diag.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Build::Make.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Build::SearchDep.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Probe.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Fetch::Local.3pm
Installing /usr/local/share/man/man3/Alien::Build::Manual::AlienAuthor.3pm
Installing /usr/local/share/man/man3/Test::Alien::Run.3pm
Installing /usr/local/share/man/man3/Alien::Build::Version::Basic.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Build.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Core::Tail.3pm
Installing /usr/local/share/man/man3/Alien::Build::Log::Default.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Prefer.3pm
Installing /usr/local/share/man/man3/Alien::Base.3pm
Installing /usr/local/share/man/man3/Test::Alien.3pm
Installing /usr/local/share/man/man3/Alien::Role.3pm
Installing /usr/local/share/man/man3/Alien::Build::MM.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::PkgConfig::PP.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Extract::Negotiate.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Decode::Mojo.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Probe::CommandLine.3pm
Installing /usr/local/share/man/man3/Alien::Base::Authoring.3pm
Installing /usr/local/share/man/man3/Alien::Base::PkgConfig.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Core::Gather.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Decode::DirListingFtpcopy.3pm
Installing /usr/local/share/man/man3/Test::Alien::Build.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Core::Legacy.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::PkgConfig::LibPkgConf.3pm
Installing /usr/local/share/man/man3/Alien::Build::Plugin::Prefer::GoodVersion.3pm
Installing /usr/local/share/man/man3/Alien::Build.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  PLICEASE/Alien-Build-2.37.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'Alien::Libxml2'
Running make for P/PL/PLICEASE/Alien-Libxml2-0.17.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/P/PL/PLICEASE/Alien-Libxml2-0.17.tar.gz
Checksum for /root/.cpan/sources/authors/id/P/PL/PLICEASE/Alien-Libxml2-0.17.tar.gz ok
Alien-Libxml2-0.17
Alien-Libxml2-0.17/README
Alien-Libxml2-0.17/Changes
Alien-Libxml2-0.17/LICENSE
Alien-Libxml2-0.17/INSTALL
Alien-Libxml2-0.17/dist.ini
Alien-Libxml2-0.17/META.yml
Alien-Libxml2-0.17/MANIFEST
Alien-Libxml2-0.17/alienfile
Alien-Libxml2-0.17/META.json
Alien-Libxml2-0.17/author.yml
Alien-Libxml2-0.17/t/c
Alien-Libxml2-0.17/t/c/test.c
Alien-Libxml2-0.17/t
Alien-Libxml2-0.17/t/00_diag.t
Alien-Libxml2-0.17/Makefile.PL
Alien-Libxml2-0.17/perlcriticrc
Alien-Libxml2-0.17/xt/author
Alien-Libxml2-0.17/xt/author/eol.t
Alien-Libxml2-0.17/xt/author/pod.t
Alien-Libxml2-0.17/corpus
Alien-Libxml2-0.17/corpus/basic.xml
Alien-Libxml2-0.17/t/alien_libxml2.t
Alien-Libxml2-0.17/xt/author/critic.t
Alien-Libxml2-0.17/xt/author/strict.t
Alien-Libxml2-0.17/xt/release
Alien-Libxml2-0.17/xt/release/fixme.t
Alien-Libxml2-0.17/xt/author/no_tabs.t
Alien-Libxml2-0.17/xt/author/version.t
Alien-Libxml2-0.17/lib/Alien
Alien-Libxml2-0.17/lib/Alien/Libxml2.pm
Alien-Libxml2-0.17/xt/release/changes.t
Alien-Libxml2-0.17/maint
Alien-Libxml2-0.17/maint/cip-before-install
Alien-Libxml2-0.17/xt/author/pod_coverage.t
Alien-Libxml2-0.17/maint/tags-to-versions.pl
Alien-Libxml2-0.17/xt/author/pod_spelling_common.t
Alien-Libxml2-0.17/xt/author/pod_spelling_system.t

  CPAN.pm: Building P/PL/PLICEASE/Alien-Libxml2-0.17.tar.gz

Alien::Build::Plugin::PkgConfig::Negotiate> Using PkgConfig plugin: PkgConfig::CommandLine
Alien::Build::CommandSequence> + xml2-config --version
Alien::Build::CommandSequence> [output consumed by Alien::Build recipe]
Alien::Build::CommandSequence> + xml2-config --cflags
Alien::Build::CommandSequence> [output consumed by Alien::Build recipe]
Alien::Build::CommandSequence> + xml2-config --libs
Alien::Build::CommandSequence> [output consumed by Alien::Build recipe]
Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for Alien::Libxml2
Writing MYMETA.yml and MYMETA.json
cp lib/Alien/Libxml2.pm blib/lib/Alien/Libxml2.pm
"/usr/bin/perl" -MAlien::Build::MM=cmd -e prefix site /usr/lib64/perl5 /usr/local/lib64/perl5 /usr/lib64/perl5/vendor_perl
Alien::Build::Plugin::PkgConfig::Negotiate> Using PkgConfig plugin: PkgConfig::CommandLine
main> prefix /usr/local/lib64/perl5/auto/share/dist/Alien-Libxml2
"/usr/bin/perl" -MAlien::Build::MM=cmd -e version 0.17
Alien::Build::Plugin::PkgConfig::Negotiate> Using PkgConfig plugin: PkgConfig::CommandLine
"/usr/bin/perl" -MAlien::Build::MM=cmd -e download
Alien::Build::Plugin::PkgConfig::Negotiate> Using PkgConfig plugin: PkgConfig::CommandLine
"/usr/bin/perl" -MAlien::Build::MM=cmd -e build
Alien::Build::Plugin::PkgConfig::Negotiate> Using PkgConfig plugin: PkgConfig::CommandLine
Alien::Build::Plugin::Core::Legacy> adding legacy hash to config
Alien::Build::Plugin::Core::Gather> mkdir -p /root/.cpan/build/Alien-Libxml2-0.17-sEkEhP/blib/lib/auto/share/dist/Alien-Libxml2/_alien
Manifying 1 pod document
  PLICEASE/Alien-Libxml2-0.17.tar.gz
  /usr/bin/make -- OK
Running make test
"/usr/bin/perl" -MAlien::Build::MM=cmd -e test
Alien::Build::Plugin::PkgConfig::Negotiate> Using PkgConfig plugin: PkgConfig::CommandLine
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00_diag.t ........ 1/? #
#
#
# HARNESS_ACTIVE=1
# HARNESS_VERSION=3.17
# LANG=en_US.UTF-8
# PERL5LIB=/root/.cpan/build/Alien-Libxml2-0.17-sEkEhP/blib/lib:/root/.cpan/build/Alien-Libxml2-0.17-sEkEhP/blib/arch:
# PERL5OPT=
# PERL5_CPANPLUS_IS_RUNNING=27355
# PERL5_CPAN_IS_RUNNING=27355
# PERL_DL_NONLAZY=1
# SHELL=/bin/bash
#
#
#
# PERL5LIB path
# /root/.cpan/build/Alien-Libxml2-0.17-sEkEhP/blib/lib
# /root/.cpan/build/Alien-Libxml2-0.17-sEkEhP/blib/arch
#
#
#
# perl                                     5.010001 linux x86_64-linux-thread-multi
# Alien::Base                              2.37
# Alien::Build                             2.37
# Alien::Build::MM                         2.37
# Alien::Build::Plugin::Build::SearchDep   2.37
# Alien::Build::Plugin::Prefer::BadVersion 2.37
# Alien::Build::Plugin::Probe::Vcpkg       2.37
# ExtUtils::CBuilder                       0.27
# ExtUtils::MakeMaker                      7.58
# Test2::V0                                0.000139
# Test::Alien                              2.37
#
#
#
# version        = 2.7.6
# cflags         = -I/usr/include/libxml2
# cflags_static  = -I/usr/include/libxml2
# libs           = -lxml2 -lz -lm
# libs_static    = -lxml2 -lz -lm
#
#
#
t/00_diag.t ........ ok
t/alien_libxml2.t .. ok
All tests successful.
Files=2, Tests=4,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.38 cusr  0.08 csys =  0.47 CPU)
Result: PASS
  PLICEASE/Alien-Libxml2-0.17.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/Alien-Libxml2-0.17-sEkEhP/blib/arch /root/.cpan/build/Alien-Libxml2-0.17-sEkEhP/blib/lib to PERL5LIB for 'install'
"/usr/bin/perl" -MAlien::Build::MM=cmd -e clean_install
Alien::Build::Plugin::PkgConfig::Negotiate> Using PkgConfig plugin: PkgConfig::CommandLine
Manifying 1 pod document
Files found in blib/arch: installing files in blib/lib into architecture dependent library tree
Installing /usr/local/lib64/perl5/auto/Alien/Libxml2/Libxml2.txt
Installing /usr/local/lib64/perl5/Alien/Libxml2.pm
Installing /usr/local/lib64/perl5/Alien/Libxml2/Install/Files.pm
Installing /usr/local/lib64/perl5/auto/share/dist/Alien-Libxml2/_alien/alien.json
Installing /usr/local/lib64/perl5/auto/share/dist/Alien-Libxml2/_alien/alienfile
Installing /usr/local/share/man/man3/Alien::Libxml2.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  PLICEASE/Alien-Libxml2-0.17.tar.gz
  /usr/bin/make install  -- OK
Running make for S/SH/SHLOMIF/XML-LibXML-2.0206.tar.gz

  CPAN.pm: Building S/SH/SHLOMIF/XML-LibXML-2.0206.tar.gz

Checking if your kit is complete...
Looks good
Warning: prerequisite XML::NamespaceSupport 1.07 not found.
Warning: prerequisite XML::SAX 0.11 not found.
Warning: prerequisite XML::SAX::Base 0 not found.
Warning: prerequisite XML::SAX::DocumentLocator 0 not found.
Warning: prerequisite XML::SAX::Exception 0 not found.
Generating a Unix-style Makefile
Writing Makefile for XML::LibXML
Writing MYMETA.yml and MYMETA.json
---- Unsatisfied dependencies detected during ----
----     SHLOMIF/XML-LibXML-2.0206.tar.gz     ----
    XML::SAX [requires]
    XML::SAX::Base [requires]
    XML::SAX::DocumentLocator [requires]
    XML::SAX::Exception [requires]
    XML::NamespaceSupport [requires]
Running make test
  Delayed until after prerequisites
Running make install
  Delayed until after prerequisites
Running install for module 'XML::SAX'
Running make for G/GR/GRANTM/XML-SAX-1.02.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/G/GR/GRANTM/XML-SAX-1.02.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/G/GR/GRANTM/CHECKSUMS
Checksum for /root/.cpan/sources/authors/id/G/GR/GRANTM/XML-SAX-1.02.tar.gz ok
XML-SAX-1.02/
XML-SAX-1.02/testfiles/
XML-SAX-1.02/testfiles/06e.xml
XML-SAX-1.02/testfiles/01.xml
XML-SAX-1.02/testfiles/utf-16le.xml
XML-SAX-1.02/testfiles/06c.xml
XML-SAX-1.02/testfiles/utf-16.xml
XML-SAX-1.02/testfiles/iso8859_2.xml
XML-SAX-1.02/testfiles/06f.xml
XML-SAX-1.02/testfiles/03a.xml
XML-SAX-1.02/testfiles/03b.xml
XML-SAX-1.02/testfiles/06g.xml
XML-SAX-1.02/testfiles/02b.xml
XML-SAX-1.02/testfiles/06a.xml
XML-SAX-1.02/testfiles/06b.xml
XML-SAX-1.02/testfiles/02a.xml
XML-SAX-1.02/testfiles/04a.xml
XML-SAX-1.02/testfiles/iso8859_1.xml
XML-SAX-1.02/testfiles/xmltest.xml
XML-SAX-1.02/testfiles/koi8_r.xml
XML-SAX-1.02/testfiles/06d.xml
XML-SAX-1.02/t/
XML-SAX-1.02/t/12miscstart.t
XML-SAX-1.02/t/30parse_file.t
XML-SAX-1.02/t/10xmldecl1.t
XML-SAX-1.02/t/40cdata.t
XML-SAX-1.02/t/01known.t
XML-SAX-1.02/t/42entities.t
XML-SAX-1.02/t/00basic.t
XML-SAX-1.02/t/20factory.t
XML-SAX-1.02/t/19pi.t
XML-SAX-1.02/t/13int_ent.t
XML-SAX-1.02/t/16large.t
XML-SAX-1.02/t/21saxini.t
XML-SAX-1.02/t/14encoding.t
XML-SAX-1.02/t/11xmldecl2.t
XML-SAX-1.02/t/15element.t
XML-SAX-1.02/t/99cleanup.t
XML-SAX-1.02/lib/
XML-SAX-1.02/lib/XML/
XML-SAX-1.02/lib/XML/SAX/
XML-SAX-1.02/lib/XML/SAX/PurePerl/
XML-SAX-1.02/lib/XML/SAX/PurePerl/DocType.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/DebugHandler.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/DTDDecls.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/EncodingDetect.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/XMLDecl.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/UnicodeExt.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/Reader.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/Reader/
XML-SAX-1.02/lib/XML/SAX/PurePerl/Reader/String.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/Reader/URI.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/Reader/UnicodeExt.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/Reader/Stream.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/Reader/NoUnicodeExt.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/Exception.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/Productions.pm
XML-SAX-1.02/lib/XML/SAX/PurePerl/NoUnicodeExt.pm
XML-SAX-1.02/lib/XML/SAX/Intro.pod
XML-SAX-1.02/lib/XML/SAX/PurePerl.pm
XML-SAX-1.02/lib/XML/SAX/DocumentLocator.pm
XML-SAX-1.02/lib/XML/SAX/ParserFactory.pm
XML-SAX-1.02/lib/XML/SAX.pm
XML-SAX-1.02/Changes
XML-SAX-1.02/MANIFEST
XML-SAX-1.02/Makefile.PL
XML-SAX-1.02/META.yml
XML-SAX-1.02/META.json
XML-SAX-1.02/README
XML-SAX-1.02/LICENSE

  CPAN.pm: Building G/GR/GRANTM/XML-SAX-1.02.tar.gz

Checking if your kit is complete...
Looks good
Warning: prerequisite XML::NamespaceSupport 0.03 not found.
Warning: prerequisite XML::SAX::Base 1.05 not found.
Generating a Unix-style Makefile
Writing Makefile for XML::SAX
Writing MYMETA.yml and MYMETA.json
---- Unsatisfied dependencies detected during ----
----        GRANTM/XML-SAX-1.02.tar.gz        ----
    XML::SAX::Base [requires]
    XML::NamespaceSupport [requires]
Running make test
  Delayed until after prerequisites
Running make install
  Delayed until after prerequisites
Running install for module 'XML::SAX::Base'
Running make for G/GR/GRANTM/XML-SAX-Base-1.09.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/G/GR/GRANTM/XML-SAX-Base-1.09.tar.gz
Checksum for /root/.cpan/sources/authors/id/G/GR/GRANTM/XML-SAX-Base-1.09.tar.gz ok
XML-SAX-Base-1.09/
XML-SAX-Base-1.09/BuildSAXBase.pl
XML-SAX-Base-1.09/META.yml
XML-SAX-Base-1.09/MANIFEST
XML-SAX-Base-1.09/dist.ini
XML-SAX-Base-1.09/Makefile.PL
XML-SAX-Base-1.09/META.json
XML-SAX-Base-1.09/Changes
XML-SAX-Base-1.09/lib/
XML-SAX-Base-1.09/lib/XML/
XML-SAX-Base-1.09/lib/XML/SAX/
XML-SAX-Base-1.09/lib/XML/SAX/Exception.pm
XML-SAX-Base-1.09/lib/XML/SAX/Base.pm
XML-SAX-Base-1.09/t/
XML-SAX-Base-1.09/t/02simplefilter.t
XML-SAX-Base-1.09/t/04chfilter.t
XML-SAX-Base-1.09/t/events.pl
XML-SAX-Base-1.09/t/05dtdhdriver.t
XML-SAX-Base-1.09/t/14downstreamswitch.t
XML-SAX-Base-1.09/t/10dochdriver.t
XML-SAX-Base-1.09/t/01exception.t
XML-SAX-Base-1.09/t/09resoldriver.t
XML-SAX-Base-1.09/t/06lexhdriver.t
XML-SAX-Base-1.09/t/00basic.t
XML-SAX-Base-1.09/t/08errorhdriver.t
XML-SAX-Base-1.09/t/03chdriver.t
XML-SAX-Base-1.09/t/13handlerswitch.t
XML-SAX-Base-1.09/t/01simpledriver.t
XML-SAX-Base-1.09/t/release-pod-syntax.t
XML-SAX-Base-1.09/t/07declhdriver.t
XML-SAX-Base-1.09/t/12sax2multiclass.t
XML-SAX-Base-1.09/t/15parentswitch.t
XML-SAX-Base-1.09/t/16gethandlers.t
XML-SAX-Base-1.09/t/11sax1multiclass.t
XML-SAX-Base-1.09/README

  CPAN.pm: Building G/GR/GRANTM/XML-SAX-Base-1.09.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for XML::SAX::Base
Writing MYMETA.yml and MYMETA.json
cp lib/XML/SAX/Base.pm blib/lib/XML/SAX/Base.pm
cp BuildSAXBase.pl blib/lib/XML/SAX/BuildSAXBase.pl
cp lib/XML/SAX/Exception.pm blib/lib/XML/SAX/Exception.pm
Manifying 3 pod documents
  GRANTM/XML-SAX-Base-1.09.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00basic.t ............. ok
t/01exception.t ......... ok
t/01simpledriver.t ...... ok
t/02simplefilter.t ...... ok
t/03chdriver.t .......... ok
t/04chfilter.t .......... ok
t/05dtdhdriver.t ........ ok
t/06lexhdriver.t ........ ok
t/07declhdriver.t ....... ok
t/08errorhdriver.t ...... ok
t/09resoldriver.t ....... ok
t/10dochdriver.t ........ ok
t/11sax1multiclass.t .... ok
t/12sax2multiclass.t .... ok
t/13handlerswitch.t ..... ok
t/14downstreamswitch.t .. ok
t/15parentswitch.t ...... ok
t/16gethandlers.t ....... ok
t/release-pod-syntax.t .. skipped: these tests are for release candidate testing
All tests successful.
Files=19, Tests=137,  1 wallclock secs ( 0.07 usr  0.02 sys +  0.25 cusr  0.05 csys =  0.39 CPU)
Result: PASS
  GRANTM/XML-SAX-Base-1.09.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/XML-SAX-Base-1.09-9DvSN5/blib/arch /root/.cpan/build/XML-SAX-Base-1.09-9DvSN5/blib/lib to PERL5LIB for 'install'
Manifying 3 pod documents
Installing /usr/local/share/perl5/XML/SAX/BuildSAXBase.pl
Installing /usr/local/share/perl5/XML/SAX/Base.pm
Installing /usr/local/share/perl5/XML/SAX/Exception.pm
Installing /usr/local/share/man/man3/XML::SAX::BuildSAXBase.3pm
Installing /usr/local/share/man/man3/XML::SAX::Exception.3pm
Installing /usr/local/share/man/man3/XML::SAX::Base.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  GRANTM/XML-SAX-Base-1.09.tar.gz
  /usr/bin/make install  -- OK
Running install for module 'XML::NamespaceSupport'
Running make for P/PE/PERIGRIN/XML-NamespaceSupport-1.12.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/P/PE/PERIGRIN/XML-NamespaceSupport-1.12.tar.gz
Fetching with LWP:
ftp://cpan.cs.utah.edu/CPAN/authors/id/P/PE/PERIGRIN/CHECKSUMS
Checksum for /root/.cpan/sources/authors/id/P/PE/PERIGRIN/XML-NamespaceSupport-1.12.tar.gz ok
XML-NamespaceSupport-1.12
XML-NamespaceSupport-1.12/README
XML-NamespaceSupport-1.12/Changes
XML-NamespaceSupport-1.12/LICENSE
XML-NamespaceSupport-1.12/dist.ini
XML-NamespaceSupport-1.12/META.yml
XML-NamespaceSupport-1.12/cpanfile
XML-NamespaceSupport-1.12/MANIFEST
XML-NamespaceSupport-1.12/META.json
XML-NamespaceSupport-1.12/t
XML-NamespaceSupport-1.12/t/00base.t
XML-NamespaceSupport-1.12/weaver.ini
XML-NamespaceSupport-1.12/Makefile.PL
XML-NamespaceSupport-1.12/lib/XML
XML-NamespaceSupport-1.12/lib/XML/NamespaceSupport.pm

  CPAN.pm: Building P/PE/PERIGRIN/XML-NamespaceSupport-1.12.tar.gz

Checking if your kit is complete...
Looks good
Generating a Unix-style Makefile
Writing Makefile for XML::NamespaceSupport
Writing MYMETA.yml and MYMETA.json
cp lib/XML/NamespaceSupport.pm blib/lib/XML/NamespaceSupport.pm
Manifying 1 pod document
  PERIGRIN/XML-NamespaceSupport-1.12.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00base.t .. ok
All tests successful.
Files=1, Tests=49,  0 wallclock secs ( 0.01 usr  0.00 sys +  0.03 cusr  0.00 csys =  0.04 CPU)
Result: PASS
  PERIGRIN/XML-NamespaceSupport-1.12.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/XML-NamespaceSupport-1.12-IaOLLY/blib/arch /root/.cpan/build/XML-NamespaceSupport-1.12-IaOLLY/blib/lib to PERL5LIB for 'install'
Manifying 1 pod document
Installing /usr/local/share/perl5/XML/NamespaceSupport.pm
Installing /usr/local/share/man/man3/XML::NamespaceSupport.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
  PERIGRIN/XML-NamespaceSupport-1.12.tar.gz
  /usr/bin/make install  -- OK
Running make for G/GR/GRANTM/XML-SAX-1.02.tar.gz
  Has already been unwrapped into directory /root/.cpan/build/XML-SAX-1.02-XfNlbt

  CPAN.pm: Building G/GR/GRANTM/XML-SAX-1.02.tar.gz

cp lib/XML/SAX/PurePerl/Reader/UnicodeExt.pm blib/lib/XML/SAX/PurePerl/Reader/UnicodeExt.pm
cp lib/XML/SAX/PurePerl/EncodingDetect.pm blib/lib/XML/SAX/PurePerl/EncodingDetect.pm
cp lib/XML/SAX/PurePerl/Reader/Stream.pm blib/lib/XML/SAX/PurePerl/Reader/Stream.pm
cp lib/XML/SAX/PurePerl/Reader/NoUnicodeExt.pm blib/lib/XML/SAX/PurePerl/Reader/NoUnicodeExt.pm
cp lib/XML/SAX/PurePerl/DTDDecls.pm blib/lib/XML/SAX/PurePerl/DTDDecls.pm
cp lib/XML/SAX.pm blib/lib/XML/SAX.pm
cp lib/XML/SAX/PurePerl/Reader/String.pm blib/lib/XML/SAX/PurePerl/Reader/String.pm
cp lib/XML/SAX/DocumentLocator.pm blib/lib/XML/SAX/DocumentLocator.pm
cp lib/XML/SAX/PurePerl/UnicodeExt.pm blib/lib/XML/SAX/PurePerl/UnicodeExt.pm
cp lib/XML/SAX/PurePerl/Exception.pm blib/lib/XML/SAX/PurePerl/Exception.pm
cp lib/XML/SAX/PurePerl/DocType.pm blib/lib/XML/SAX/PurePerl/DocType.pm
cp lib/XML/SAX/PurePerl/DebugHandler.pm blib/lib/XML/SAX/PurePerl/DebugHandler.pm
cp lib/XML/SAX/Intro.pod blib/lib/XML/SAX/Intro.pod
cp lib/XML/SAX/ParserFactory.pm blib/lib/XML/SAX/ParserFactory.pm
cp lib/XML/SAX/PurePerl/Reader/URI.pm blib/lib/XML/SAX/PurePerl/Reader/URI.pm
cp lib/XML/SAX/PurePerl/XMLDecl.pm blib/lib/XML/SAX/PurePerl/XMLDecl.pm
cp lib/XML/SAX/PurePerl/Reader.pm blib/lib/XML/SAX/PurePerl/Reader.pm
cp lib/XML/SAX/PurePerl.pm blib/lib/XML/SAX/PurePerl.pm
cp lib/XML/SAX/PurePerl/NoUnicodeExt.pm blib/lib/XML/SAX/PurePerl/NoUnicodeExt.pm
cp lib/XML/SAX/PurePerl/Productions.pm blib/lib/XML/SAX/PurePerl/Productions.pm
Manifying 6 pod documents
  GRANTM/XML-SAX-1.02.tar.gz
  /usr/bin/make -- OK
Running make test
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00basic.t ....... ok
t/01known.t ....... ok
t/10xmldecl1.t .... ok
t/11xmldecl2.t .... ok
t/12miscstart.t ... ok
t/13int_ent.t ..... ok
t/14encoding.t .... ok
t/15element.t ..... ok
t/16large.t ....... 1/3 parsed 80085 bytes in 0 seconds
t/16large.t ....... ok
t/19pi.t .......... ok
t/20factory.t ..... ok
t/21saxini.t ...... ok
t/30parse_file.t .. ok
t/40cdata.t ....... ok
t/42entities.t .... ok
t/99cleanup.t ..... ok
All tests successful.
Files=16, Tests=113,  1 wallclock secs ( 0.05 usr  0.02 sys +  0.72 cusr  0.10 csys =  0.89 CPU)
Result: PASS
  GRANTM/XML-SAX-1.02.tar.gz
  /usr/bin/make test -- OK
Running make install
Prepending /root/.cpan/build/XML-SAX-1.02-XfNlbt/blib/arch /root/.cpan/build/XML-SAX-1.02-XfNlbt/blib/lib to PERL5LIB for 'install'
Manifying 6 pod documents
Installing /usr/local/share/perl5/XML/SAX.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl.pm
Installing /usr/local/share/perl5/XML/SAX/ParserFactory.pm
Installing /usr/local/share/perl5/XML/SAX/Intro.pod
Installing /usr/local/share/perl5/XML/SAX/DocumentLocator.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/UnicodeExt.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/Reader.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/DocType.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/NoUnicodeExt.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/XMLDecl.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/Productions.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/Exception.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/DebugHandler.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/EncodingDetect.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/DTDDecls.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/Reader/UnicodeExt.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/Reader/NoUnicodeExt.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/Reader/URI.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/Reader/String.pm
Installing /usr/local/share/perl5/XML/SAX/PurePerl/Reader/Stream.pm
Installing /usr/local/share/man/man3/XML::SAX::Intro.3pm
Installing /usr/local/share/man/man3/XML::SAX::PurePerl.3pm
Installing /usr/local/share/man/man3/XML::SAX.3pm
Installing /usr/local/share/man/man3/XML::SAX::ParserFactory.3pm
Installing /usr/local/share/man/man3/XML::SAX::DocumentLocator.3pm
Installing /usr/local/share/man/man3/XML::SAX::PurePerl::Reader.3pm
Appending installation info to /usr/lib64/perl5/perllocal.pod
could not find ParserDetails.ini in /root/.cpan/build/XML-SAX-1.02-XfNlbt/blib/lib/XML/SAX
  GRANTM/XML-SAX-1.02.tar.gz
  /usr/bin/make install  -- OK
XML::SAX::DocumentLocator is up to date (undef).
XML::SAX::Exception is up to date (1.09).
Running make for S/SH/SHLOMIF/XML-LibXML-2.0206.tar.gz
  Has already been unwrapped into directory /root/.cpan/build/XML-LibXML-2.0206-0MmN2e

  CPAN.pm: Building S/SH/SHLOMIF/XML-LibXML-2.0206.tar.gz

cp lib/XML/LibXML/Devel.pm blib/lib/XML/LibXML/Devel.pm
cp lib/XML/LibXML/ErrNo.pod blib/lib/XML/LibXML/ErrNo.pod
cp lib/XML/LibXML/DOM.pod blib/lib/XML/LibXML/DOM.pod
cp lib/XML/LibXML/SAX/Builder.pm blib/lib/XML/LibXML/SAX/Builder.pm
cp lib/XML/LibXML/DocumentFragment.pod blib/lib/XML/LibXML/DocumentFragment.pod
cp lib/XML/LibXML/Reader.pm blib/lib/XML/LibXML/Reader.pm
cp lib/XML/LibXML/InputCallback.pod blib/lib/XML/LibXML/InputCallback.pod
cp lib/XML/LibXML/SAX/Builder.pod blib/lib/XML/LibXML/SAX/Builder.pod
cp lib/XML/LibXML/Namespace.pod blib/lib/XML/LibXML/Namespace.pod
cp lib/XML/LibXML/Document.pod blib/lib/XML/LibXML/Document.pod
cp lib/XML/LibXML/Attr.pod blib/lib/XML/LibXML/Attr.pod
cp lib/XML/LibXML/SAX/Generator.pm blib/lib/XML/LibXML/SAX/Generator.pm
cp lib/XML/LibXML/CDATASection.pod blib/lib/XML/LibXML/CDATASection.pod
cp lib/XML/LibXML/Reader.pod blib/lib/XML/LibXML/Reader.pod
cp LibXML.pod blib/lib/XML/LibXML.pod
cp lib/XML/LibXML/Common.pod blib/lib/XML/LibXML/Common.pod
cp lib/XML/LibXML/RelaxNG.pod blib/lib/XML/LibXML/RelaxNG.pod
cp lib/XML/LibXML/PI.pod blib/lib/XML/LibXML/PI.pod
cp lib/XML/LibXML/ErrNo.pm blib/lib/XML/LibXML/ErrNo.pm
cp lib/XML/LibXML/Error.pod blib/lib/XML/LibXML/Error.pod
cp lib/XML/LibXML/Comment.pod blib/lib/XML/LibXML/Comment.pod
cp lib/XML/LibXML/Dtd.pod blib/lib/XML/LibXML/Dtd.pod
cp lib/XML/LibXML/SAX.pm blib/lib/XML/LibXML/SAX.pm
cp lib/XML/LibXML/Number.pm blib/lib/XML/LibXML/Number.pm
cp lib/XML/LibXML/Literal.pm blib/lib/XML/LibXML/Literal.pm
cp lib/XML/LibXML/Node.pod blib/lib/XML/LibXML/Node.pod
cp LibXML.pm blib/lib/XML/LibXML.pm
cp lib/XML/LibXML/Parser.pod blib/lib/XML/LibXML/Parser.pod
cp lib/XML/LibXML/SAX/Parser.pm blib/lib/XML/LibXML/SAX/Parser.pm
cp lib/XML/LibXML/Element.pod blib/lib/XML/LibXML/Element.pod
cp lib/XML/LibXML/SAX.pod blib/lib/XML/LibXML/SAX.pod
cp lib/XML/LibXML/Common.pm blib/lib/XML/LibXML/Common.pm
cp lib/XML/LibXML/XPathContext.pm blib/lib/XML/LibXML/XPathContext.pm
cp lib/XML/LibXML/Error.pm blib/lib/XML/LibXML/Error.pm
cp lib/XML/LibXML/Text.pod blib/lib/XML/LibXML/Text.pod
cp lib/XML/LibXML/AttributeHash.pm blib/lib/XML/LibXML/AttributeHash.pm
cp lib/XML/LibXML/Boolean.pm blib/lib/XML/LibXML/Boolean.pm
cp lib/XML/LibXML/Schema.pod blib/lib/XML/LibXML/Schema.pod
cp lib/XML/LibXML/RegExp.pod blib/lib/XML/LibXML/RegExp.pod
cp lib/XML/LibXML/NodeList.pm blib/lib/XML/LibXML/NodeList.pm
cp lib/XML/LibXML/Pattern.pod blib/lib/XML/LibXML/Pattern.pod
cp lib/XML/LibXML/XPathExpression.pod blib/lib/XML/LibXML/XPathExpression.pod
cp lib/XML/LibXML/XPathContext.pod blib/lib/XML/LibXML/XPathContext.pod
Running Mkbootstrap for LibXML ()
chmod 644 "LibXML.bs"
"/usr/bin/perl" -MExtUtils::Command::MM -e 'cp_nonempty' -- LibXML.bs blib/arch/auto/XML/LibXML/LibXML.bs 644
gcc -c  -I/usr/include/libxml2 -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic   -DVERSION=\"2.0206\" -DXS_VERSION=\"2.0206\" -fPIC "-I/usr/lib64/perl5/CORE"  -DHAVE_UTF8 Av_CharPtrPtr.c
"/usr/bin/perl" "/usr/local/share/perl5/ExtUtils/xsubpp"  -typemap '/usr/share/perl5/ExtUtils/typemap' -typemap '/root/.cpan/build/XML-LibXML-2.0206-0MmN2e/typemap'  Devel.xs > Devel.xsc
mv Devel.xsc Devel.c
gcc -c  -I/usr/include/libxml2 -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic   -DVERSION=\"2.0206\" -DXS_VERSION=\"2.0206\" -fPIC "-I/usr/lib64/perl5/CORE"  -DHAVE_UTF8 Devel.c
"/usr/bin/perl" "/usr/local/share/perl5/ExtUtils/xsubpp"  -typemap '/usr/share/perl5/ExtUtils/typemap' -typemap '/root/.cpan/build/XML-LibXML-2.0206-0MmN2e/typemap'  LibXML.xs > LibXML.xsc
mv LibXML.xsc LibXML.c
gcc -c  -I/usr/include/libxml2 -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic   -DVERSION=\"2.0206\" -DXS_VERSION=\"2.0206\" -fPIC "-I/usr/lib64/perl5/CORE"  -DHAVE_UTF8 LibXML.c
LibXML.c: In function ‘XS_XML__LibXML__Node_unbindNode’:
LibXML.xs:4982: warning: unused variable ‘docfrag’
gcc -c  -I/usr/include/libxml2 -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic   -DVERSION=\"2.0206\" -DXS_VERSION=\"2.0206\" -fPIC "-I/usr/lib64/perl5/CORE"  -DHAVE_UTF8 dom.c
gcc -c  -I/usr/include/libxml2 -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic   -DVERSION=\"2.0206\" -DXS_VERSION=\"2.0206\" -fPIC "-I/usr/lib64/perl5/CORE"  -DHAVE_UTF8 perl-libxml-mm.c
gcc -c  -I/usr/include/libxml2 -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic   -DVERSION=\"2.0206\" -DXS_VERSION=\"2.0206\" -fPIC "-I/usr/lib64/perl5/CORE"  -DHAVE_UTF8 perl-libxml-sax.c
perl-libxml-sax.c: In function ‘PSaxSetDocumentLocator’:
perl-libxml-sax.c:883: warning: unused variable ‘empty’
gcc -c  -I/usr/include/libxml2 -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic   -DVERSION=\"2.0206\" -DXS_VERSION=\"2.0206\" -fPIC "-I/usr/lib64/perl5/CORE"  -DHAVE_UTF8 xpath.c
rm -f blib/arch/auto/XML/LibXML/LibXML.so
LD_RUN_PATH="/usr/lib64:/lib64" gcc  -shared -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic  Av_CharPtrPtr.o Devel.o LibXML.o dom.o perl-libxml-mm.o perl-libxml-sax.o xpath.o  -o blib/arch/auto/XML/LibXML/LibXML.so  \
           -lxml2 -lz -lm   \

chmod 755 blib/arch/auto/XML/LibXML/LibXML.so
Manifying 34 pod documents
  SHLOMIF/XML-LibXML-2.0206.tar.gz
  /usr/bin/make -- OK
Running make test
"/usr/bin/perl" -MExtUtils::Command::MM -e 'cp_nonempty' -- LibXML.bs blib/arch/auto/XML/LibXML/LibXML.bs 644
PERL_DL_NONLAZY=1 "/usr/bin/perl" "-MExtUtils::Command::MM" "-MTest::Harness" "-e" "undef *Test::Harness::Switches; test_harness(0, 'blib/lib', 'blib/arch')" t/*.t
t/00-report-prereqs.t .............................. #
# Versions for all modules listed in MYMETA.json (including optional ones):
#
# === Configure Requires ===
#
#     Module               Want  Have
#     -------------------- ---- -----
#     Alien::Base::Wrapper  any  2.37
#     Alien::Libxml2       0.14  0.17
#     Config                any undef
#     ExtUtils::MakeMaker   any  7.58
#
# === Build Requires ===
#
#     Module              Want Have
#     ------------------- ---- ----
#     ExtUtils::MakeMaker  any 7.58
#
# === Test Requires ===
#
#     Module       Want     Have
#     ------------ ---- --------
#     Config        any    undef
#     Errno         any     1.11
#     IO::File      any     1.14
#     IO::Handle    any     1.28
#     POSIX         any     1.17
#     Scalar::Util  any     1.55
#     Test::More    any 1.302183
#     locale        any     1.00
#     utf8          any     1.07
#
# === Runtime Requires ===
#
#     Module                    Want  Have
#     ------------------------- ---- -----
#     Carp                       any  1.11
#     DynaLoader                 any  1.10
#     Encode                     any  2.35
#     Exporter                  5.57  5.63
#     IO::Handle                 any  1.28
#     Scalar::Util               any  1.55
#     Tie::Hash                  any  1.03
#     XML::NamespaceSupport     1.07  1.12
#     XML::SAX                  0.11  1.02
#     XML::SAX::Base             any  1.09
#     XML::SAX::DocumentLocator  any undef
#     XML::SAX::Exception        any  1.09
#     base                       any  2.14
#     constant                   any  1.17
#     overload                   any  1.07
#     parent                     any 0.221
#     strict                     any  1.04
#     vars                       any  1.01
#     warnings                   any  1.06
#
t/00-report-prereqs.t .............................. ok
t/01basic.t ........................................ 1/3 #
#
# Compiled against libxml2 version: 20706
# Running libxml2 version:          20706
#
t/01basic.t ........................................ ok
t/02parse.t ........................................ ok
t/03doc.t .......................................... ok
t/04node.t ......................................... ok
t/05text.t ......................................... ok
t/06elements.t ..................................... ok
t/07dtd.t .......................................... ok
t/08findnodes.t .................................... ok
t/09xpath.t ........................................ ok
t/10ns.t ........................................... ok
t/11memory.t ....................................... skipped: These tests are for authors only!
t/12html.t ......................................... ok
t/13dtd.t .......................................... ok
t/14sax.t .......................................... ok
t/15nodelist.t ..................................... ok
t/16docnodes.t ..................................... ok
t/17callbacks.t .................................... ok
t/18docfree.t ...................................... ok
t/19die_on_invalid_utf8_rt_58848.t ................. ok
t/19encoding.t ..................................... ok
t/20extras.t ....................................... ok
t/21catalog.t ...................................... ok
t/23rawfunctions.t ................................. ok
t/24c14n.t ......................................... ok
t/25relaxng.t ...................................... ok
t/26schema.t ....................................... ok
t/27new_callbacks_simple.t ......................... ok
t/28new_callbacks_multiple.t ....................... ok
t/29id.t ........................................... ok
t/30keep_blanks.t .................................. ok
t/30xpathcontext.t ................................. ok
t/31xpc_functions.t ................................ ok
t/32xpc_variables.t ................................ ok
t/35huge_mode.t .................................... ok
t/40reader.t ....................................... ok
t/40reader_mem_error.t ............................. ok
t/41xinclude.t ..................................... ok
t/42common.t ....................................... ok
t/43options.t ...................................... 1/291 file:///etc/passwd:486: parser error : EntityRef: expecting ';'
bctrace:zLzFwVrbP1nvE:9140:100:BI R\&D Race Testing,S2102,+1 (919) 531-6645,9999
                                      ^
file:///etc/passwd:1666: parser error : PCDATA invalid Char value 27
devsecops:jwOiSzr6nHohk:18893:108:devsecops,XXXX,x157,9999999,3329:/user
                                                       ^
file:///etc/passwd:1666: parser error : PCDATA invalid Char value 27
devsecops:jwOiSzr6nHohk:18893:108:devsecops,XXXX,x157,9999999,3329:/user
                                                          ^
file:///etc/passwd:1671: parser error : EntityRef: expecting ';'
dfxrnd:t2tdFBHxTmX36:46473:100:DFD R&D Account,229,3136,9999999,9150:/users/dfxr
                                      ^
file:///etc/passwd:2996: parser error : EntityRef: expecting ';'
javadev:yMvYA3mB6glOk:16636:100:R&D Java Development,R1240,17771,9999999,1599:/u
                                   ^
file:///etc/passwd:4667: parser error : Input is not proper UTF-8, indicate encoding !
Bytes: 0xE5 0x76 0x61 0x72
norzhp:kiHPulecvau1E:29980:117:H▒vard Pehrson,NORWAY,,,E37026:/users/norzhp:/bin
                                ^
file:///etc/passwd:4744: parser error : xmlParseEntityRef: no name
oradbt:4.gtD5AXK9t2g:33363:70:[MIS] Dunn & Bradstreet Project,E308,10434,9999999
                                          ^
file:///etc/passwd:5112: parser error : xmlParseEntityRef: no name
qstsdmdb:&8fG7r.yBmpkM:34640:100:qstsdmdb,XXXX,XXXX,9999999,5331:/users/qstsdmdb
          ^
file:///etc/passwd:5189: parser error : EntityRef: expecting ';'
rdcjenk:IkhCC922AqvpE:9349:100:[RDC] R\&D Jenkins Admin,RA432,+1 (919) 531-6196,
                                         ^
file:///etc/passwd:5221: parser error : EntityRef: expecting ';'
rdwebs:WmU/yzETQKRHQ:14789:100:R&D Generic Web ID,S2062,14533,9999999,4359:/r/ge
                                  ^
file:///etc/passwd:6785: parser error : xmlParseEntityRef: no name
sdesas:d4lXOllg0XCoE:6048:44:[SDE] Build & Test Department,R4236,16698,9999999,2
                                          ^
file:///etc/passwd:7174: parser error : EntityRef: expecting ';'
sinasc:qRIM.65KAzgvc:11223:100:Atish Chintawar,SAS R&D,XXXX,,E31605:/users/sinas
                                                      ^
file:///etc/passwd:7193: parser error : EntityRef: expecting ';'
sinawn:tLjmHhOd9.WL6:11400:100:Ashwini Annadate,SAS R&D,XXXX,,E31618:/users/sina
                                                       ^
file:///etc/passwd:7272: parser error : EntityRef: expecting ';'
singre:IbvTu4ps4Ykzw:11489:100:Ganpati Revankar,SAS R&D,XXXX,,E31623:/users/sing
                                                       ^
file:///etc/passwd:7328: parser error : EntityRef: expecting ';'
sinklg:VZ9WgHQCo5GRk:11353:100:Kanhaiya Gupta,SAS R&D,XXXX,,E31614:/users/sinklg
                                                     ^
file:///etc/passwd:7381: parser error : EntityRef: expecting ';'
sinmjh:HgDH0sVUGNqo2:11150:100:Manish Jhunjhunwala,SAS R&D,XXXX,,E31601:/users/s
                                                          ^
file:///etc/passwd:7399: parser error : EntityRef: expecting ';'
sinmru:rHy0du4d9H8nQ:11007:100:Mrudula Shrimant,SAS R&D,XXXX,,E31588:/users/sinm
                                                       ^
file:///etc/passwd:7459: parser error : EntityRef: expecting ';'
sinpkr:wEV9vuUcDg75U:10750:100:Priya Khirodkar,SAS R&D,XXXX,,E31578:/users/sinpk
                                                      ^
file:///etc/passwd:7471: parser error : EntityRef: expecting ';'
sinppw:NqgiPwtt5KkTQ:11119:100:Prasad Pawar,SAS R&D,XXXX,,E31599:/users/sinppw:/
                                                   ^
file:///etc/passwd:7481: parser error : EntityRef: expecting ';'
sinpse:I.AjGNwMJOdlg:11001:100:Pallavi Sethi,SAS R&D,XXXX,,E31587:/users/sinpse:
                                                    ^
file:///etc/passwd:7504: parser error : EntityRef: expecting ';'
sinrit:cLBhOFp7nL8lU:11099:100:Ritesh Nigam,SAS R&D,XXXX,,E31592:/users/sinrit:/
                                                   ^
file:///etc/passwd:7516: parser error : EntityRef: expecting ';'
sinrmg:s.jETp5Go.m/2:11469:100:Ramnik Gahrotra,SAS R&D,XXXX,,E31622:/users/sinrm
                                                      ^
file:///etc/passwd:7610: parser error : EntityRef: expecting ';'
sinspl:X7cn0eALPDe2M:11128:100:Suhas Papal,SAS R&D,XXXX,,E31596:/users/sinspl:/b
                                                  ^
file:///etc/passwd:9456: parser error : xmlParseEntityRef: no name
vdmrace:Dlm57/s6QXpuI:44888:100:DEI VDM Usage & RACE Deployment,R4224,17792,9999
                                               ^
file:///etc/passwd:9938: parser error : EntityRef: expecting ';'
rdt0001:slCUNJ0bcEkVI:20804:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9939: parser error : EntityRef: expecting ';'
rdt0002:slCUNJ0bcEkVI:20805:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9940: parser error : EntityRef: expecting ';'
rdt0003:slCUNJ0bcEkVI:20806:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9941: parser error : EntityRef: expecting ';'
rdt0004:slCUNJ0bcEkVI:20807:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9942: parser error : EntityRef: expecting ';'
rdt0005:slCUNJ0bcEkVI:20808:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9943: parser error : EntityRef: expecting ';'
rdt0006:slCUNJ0bcEkVI:20809:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9944: parser error : EntityRef: expecting ';'
rdt0007:slCUNJ0bcEkVI:20810:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9945: parser error : EntityRef: expecting ';'
rdt0008:slCUNJ0bcEkVI:20811:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9946: parser error : EntityRef: expecting ';'
rdt0009:slCUNJ0bcEkVI:20812:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9947: parser error : EntityRef: expecting ';'
rdt0010:slCUNJ0bcEkVI:20813:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9948: parser error : EntityRef: expecting ';'
rdt0011:slCUNJ0bcEkVI:20814:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9949: parser error : EntityRef: expecting ';'
rdt0012:slCUNJ0bcEkVI:20815:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9950: parser error : EntityRef: expecting ';'
rdt0013:slCUNJ0bcEkVI:20816:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9951: parser error : EntityRef: expecting ';'
rdt0014:slCUNJ0bcEkVI:20817:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9952: parser error : EntityRef: expecting ';'
rdt0015:slCUNJ0bcEkVI:20818:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9953: parser error : EntityRef: expecting ';'
rdt0016:slCUNJ0bcEkVI:20819:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9954: parser error : EntityRef: expecting ';'
rdt0017:slCUNJ0bcEkVI:20820:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9955: parser error : EntityRef: expecting ';'
rdt0018:slCUNJ0bcEkVI:20821:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9956: parser error : EntityRef: expecting ';'
rdt0019:slCUNJ0bcEkVI:20822:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9957: parser error : EntityRef: expecting ';'
rdt0020:slCUNJ0bcEkVI:20823:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9958: parser error : EntityRef: expecting ';'
rdt0021:slCUNJ0bcEkVI:20824:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9959: parser error : EntityRef: expecting ';'
rdt0022:slCUNJ0bcEkVI:20825:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9960: parser error : EntityRef: expecting ';'
rdt0023:slCUNJ0bcEkVI:20826:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9961: parser error : EntityRef: expecting ';'
rdt0024:slCUNJ0bcEkVI:20827:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9962: parser error : EntityRef: expecting ';'
rdt0025:slCUNJ0bcEkVI:20828:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9963: parser error : EntityRef: expecting ';'
rdt0026:slCUNJ0bcEkVI:20829:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9964: parser error : EntityRef: expecting ';'
rdt0027:slCUNJ0bcEkVI:20830:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9965: parser error : EntityRef: expecting ';'
rdt0028:slCUNJ0bcEkVI:20831:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9966: parser error : EntityRef: expecting ';'
rdt0029:slCUNJ0bcEkVI:20832:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9967: parser error : EntityRef: expecting ';'
rdt0030:slCUNJ0bcEkVI:20833:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9968: parser error : EntityRef: expecting ';'
rdt0031:slCUNJ0bcEkVI:20834:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9969: parser error : EntityRef: expecting ';'
rdt0032:slCUNJ0bcEkVI:20835:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9970: parser error : EntityRef: expecting ';'
rdt0033:slCUNJ0bcEkVI:20836:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9971: parser error : EntityRef: expecting ';'
rdt0034:slCUNJ0bcEkVI:20837:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9972: parser error : EntityRef: expecting ';'
rdt0035:slCUNJ0bcEkVI:20838:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9973: parser error : EntityRef: expecting ';'
rdt0036:slCUNJ0bcEkVI:20839:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9974: parser error : EntityRef: expecting ';'
rdt0037:slCUNJ0bcEkVI:20840:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9975: parser error : EntityRef: expecting ';'
rdt0038:slCUNJ0bcEkVI:20841:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9976: parser error : EntityRef: expecting ';'
rdt0039:slCUNJ0bcEkVI:20842:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9977: parser error : EntityRef: expecting ';'
rdt0040:slCUNJ0bcEkVI:20843:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9978: parser error : EntityRef: expecting ';'
rdt0041:slCUNJ0bcEkVI:20844:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9979: parser error : EntityRef: expecting ';'
rdt0042:slCUNJ0bcEkVI:20845:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9980: parser error : EntityRef: expecting ';'
rdt0043:slCUNJ0bcEkVI:20846:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9981: parser error : EntityRef: expecting ';'
rdt0044:slCUNJ0bcEkVI:20847:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9982: parser error : EntityRef: expecting ';'
rdt0045:slCUNJ0bcEkVI:20848:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9983: parser error : EntityRef: expecting ';'
rdt0046:slCUNJ0bcEkVI:20849:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9984: parser error : EntityRef: expecting ';'
rdt0047:slCUNJ0bcEkVI:20850:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9985: parser error : EntityRef: expecting ';'
rdt0048:slCUNJ0bcEkVI:20851:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9986: parser error : EntityRef: expecting ';'
rdt0049:slCUNJ0bcEkVI:20852:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9987: parser error : EntityRef: expecting ';'
rdt0050:slCUNJ0bcEkVI:20853:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9988: parser error : EntityRef: expecting ';'
rdt0051:slCUNJ0bcEkVI:20854:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9989: parser error : EntityRef: expecting ';'
rdt0052:slCUNJ0bcEkVI:20855:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9990: parser error : EntityRef: expecting ';'
rdt0053:slCUNJ0bcEkVI:20856:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9991: parser error : EntityRef: expecting ';'
rdt0054:slCUNJ0bcEkVI:20857:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9992: parser error : EntityRef: expecting ';'
rdt0055:slCUNJ0bcEkVI:20858:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9993: parser error : EntityRef: expecting ';'
rdt0056:slCUNJ0bcEkVI:20859:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9994: parser error : EntityRef: expecting ';'
rdt0057:slCUNJ0bcEkVI:20860:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9995: parser error : EntityRef: expecting ';'
rdt0058:slCUNJ0bcEkVI:20861:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9996: parser error : EntityRef: expecting ';'
rdt0059:slCUNJ0bcEkVI:20862:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9997: parser error : EntityRef: expecting ';'
rdt0060:slCUNJ0bcEkVI:20863:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9998: parser error : EntityRef: expecting ';'
rdt0061:slCUNJ0bcEkVI:20864:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:9999: parser error : EntityRef: expecting ';'
rdt0062:slCUNJ0bcEkVI:20865:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10000: parser error : EntityRef: expecting ';'
rdt0063:slCUNJ0bcEkVI:20866:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10001: parser error : EntityRef: expecting ';'
rdt0064:slCUNJ0bcEkVI:20867:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10002: parser error : EntityRef: expecting ';'
rdt0065:slCUNJ0bcEkVI:20868:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10003: parser error : EntityRef: expecting ';'
rdt0066:slCUNJ0bcEkVI:20869:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10004: parser error : EntityRef: expecting ';'
rdt0067:slCUNJ0bcEkVI:20870:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10005: parser error : EntityRef: expecting ';'
rdt0068:slCUNJ0bcEkVI:20871:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10006: parser error : EntityRef: expecting ';'
rdt0069:slCUNJ0bcEkVI:20872:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10007: parser error : EntityRef: expecting ';'
rdt0070:slCUNJ0bcEkVI:20873:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10008: parser error : EntityRef: expecting ';'
rdt0071:slCUNJ0bcEkVI:20874:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10009: parser error : EntityRef: expecting ';'
rdt0072:slCUNJ0bcEkVI:20875:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10010: parser error : EntityRef: expecting ';'
rdt0073:slCUNJ0bcEkVI:20876:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10011: parser error : EntityRef: expecting ';'
rdt0074:slCUNJ0bcEkVI:20877:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10012: parser error : EntityRef: expecting ';'
rdt0075:slCUNJ0bcEkVI:20878:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10013: parser error : EntityRef: expecting ';'
rdt0076:slCUNJ0bcEkVI:20879:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
file:///etc/passwd:10014: parser error : EntityRef: expecting ';'
rdt0077:slCUNJ0bcEkVI:20880:100:R&D/CTN LOCAL Test Accounts,R3208,7567,8331470,1
                                   ^
# Looks like your test exited with 255 just after 50.
t/43options.t ...................................... Dubious, test returned 255 (wstat 65280, 0xff00)
Failed 241/291 subtests
t/44extent.t ....................................... ok
t/45regex.t ........................................ ok
t/46err_column.t ................................... ok
t/47load_xml_callbacks.t ........................... ok
t/48_memleak_rt_83744.t ............................ skipped: Test::LeakTrace is required for memory leak tests.
t/48_reader_undef_warning_on_empty_str_rt106830.t .. ok
t/48_removeChild_crashes_rt_80395.t ................ ok
t/48_replaceNode_DTD_nodes_rT_80521.t .............. ok
t/48_RH5_double_free_rt83779.t ..................... skipped: Test::LeakTrace is required.
t/48_rt123379_setNamespace.t ....................... ok
t/48_rt55000.t ..................................... ok
t/48_rt93429_recover_2_in_html_parsing.t ........... ok
t/48_SAX_Builder_rt_91433.t ........................ ok
t/48importing_nodes_IDs_rt_69520.t ................. ok
t/49_load_html.t ................................... ok
t/49callbacks_returning_undef.t .................... ok
t/49global_extent.t ................................ ok
t/50devel.t ........................................ ok
t/51_parse_html_string_rt87089.t ................... ok
t/60error_prev_chain.t ............................. ok
t/60struct_error.t ................................. ok
t/61error.t ........................................ ok
t/62overload.t ..................................... ok
t/71overloads.t .................................... ok
t/72destruction.t .................................. ok
t/80registryleak.t ................................. ok
t/90shared_clone_failed_rt_91800.t ................. skipped: optional (set THREAD_TEST=1 to run these tests)
t/90stack.t ........................................ ok
t/90threads.t ...................................... skipped: optional (set THREAD_TEST=1 to run these tests)
t/91unique_key.t ................................... ok
t/cpan-changes.t ................................... skipped: These tests are for authors only!
t/pod-files-presence.t ............................. ok
t/pod.t ............................................ skipped: These tests are for authors only!
t/release-kwalitee.t ............................... skipped: These tests are for authors only!
t/style-trailing-space.t ........................... skipped: These tests are for authors only!

Test Summary Report
-------------------
t/43options.t                                    (Wstat: 65280 Tests: 50 Failed: 0)
  Non-zero exit status: 255
  Parse errors: Bad plan.  You planned 291 tests but ran 50.
Files=75, Tests=2297,  6 wallclock secs ( 0.32 usr  0.11 sys +  4.32 cusr  0.67 csys =  5.42 CPU)
Result: FAIL
Failed 1/75 test programs. 0/2297 subtests failed.
make: *** [test_dynamic] Error 255
  SHLOMIF/XML-LibXML-2.0206.tar.gz
  /usr/bin/make test -- NOT OK
//hint// to see the cpan-testers results for installing this module, try:
  reports SHLOMIF/XML-LibXML-2.0206.tar.gz
Running make install
  make test had returned bad status, won't install without force
Failed during this command:
 SHLOMIF/XML-LibXML-2.0206.tar.gz             : make_test NO

cpan[2]> exit
Terminal does not support GetHistory.
Lockfile removed.
```

后来还是通过下载rpm包解决了。  
```
[root@mryqulax ~]# lsb_release -a
LSB Version:    :core-4.0-amd64:core-4.0-noarch:graphics-4.0-amd64:graphics-4.0-noarch:printing-4.0-amd64:printing-4.0-noarch
Distributor ID: RedHatEnterpriseServer
Description:    Red Hat Enterprise Linux Server release 6.1 (Santiago)
Release:        6.1
Codename:       Santiago
[root@mryqulax ~]# wget https://vault.centos.org/6.1/os/x86_64/Packages/libxml2-devel-2.7.6-1.el6.x86_64.rpm
--2021-01-03 21:25:08--  https://vault.centos.org/6.1/os/x86_64/Packages/libxml2-devel-2.7.6-1.el6.x86_64.rpm
Resolving vault.centos.org... 3.22.185.178, 2600:1f13:2e7:2901:d2b0:c3b2:9347:934c
Connecting to vault.centos.org|3.22.185.178|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1106816 (1.1M) [application/x-rpm]
Saving to: “libxml2-devel-2.7.6-1.el6.x86_64.rpm”

100%[=====================================================================================================================================================================>] 1,106,816   1.63M/s   in 0.6s

2021-01-03 21:25:09 (1.63 MB/s) - “libxml2-devel-2.7.6-1.el6.x86_64.rpm” saved [1106816/1106816]

[root@mryqulax ~]# wget https://vault.centos.org/6.1/os/x86_64/Packages/libxml2-2.7.6-1.el6.x86_64.rpm
--2021-01-03 21:25:37--  https://vault.centos.org/6.1/os/x86_64/Packages/libxml2-2.7.6-1.el6.x86_64.rpm
Resolving vault.centos.org... 54.186.51.210, 2600:1f16:c1:5e03:a992:8ee1:99d2:6f8
Connecting to vault.centos.org|54.186.51.210|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 814352 (795K) [application/x-rpm]
Saving to: “libxml2-2.7.6-1.el6.x86_64.rpm”

100%[=====================================================================================================================================================================>] 814,352     1.40M/s   in 0.6s

2021-01-03 21:25:38 (1.40 MB/s) - “libxml2-2.7.6-1.el6.x86_64.rpm” saved [814352/814352]

[root@mryqulax ~]# rpm -ivh libxml2-devel-2.7.6-1.el6.x86_64.rpm
warning: libxml2-devel-2.7.6-1.el6.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
Preparing...                ########################################### [100%]
        package libxml2-devel-2.7.6-1.el6.x86_64 is already installed
[root@mryqulax ~]# rpm -ivh libxml2-2.7.6-1.el6.x86_64.rpm
warning: libxml2-2.7.6-1.el6.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
Preparing...                ########################################### [100%]
        package libxml2-2.7.6-1.el6.x86_64 is already installed
        file /usr/bin/xmlcatalog from install of libxml2-2.7.6-1.el6.x86_64 conflicts with file from package libxml2-2.7.6-1.el6.x86_64
        file /usr/bin/xmllint from install of libxml2-2.7.6-1.el6.x86_64 conflicts with file from package libxml2-2.7.6-1.el6.x86_64
        file /usr/lib64/libxml2.so.2.7.6 from install of libxml2-2.7.6-1.el6.x86_64 conflicts with file from package libxml2-2.7.6-1.el6.x86_64
[root@mryqulax ~]# perldoc -l XML::LibXML
No documentation found for "XML::LibXML".
[root@mryqulax ~]# wget https://vault.centos.org/6.1/os/x86_64/Packages/perl-XML-Parser-2.36-7.el6.x86_64.rpm
--2021-01-03 21:41:39--  https://vault.centos.org/6.1/os/x86_64/Packages/perl-XML-Parser-2.36-7.el6.x86_64.rpm
Resolving vault.centos.org... 3.22.185.178, 2600:1f16:c1:5e03:a992:8ee1:99d2:6f8
Connecting to vault.centos.org|3.22.185.178|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 229296 (224K) [application/x-rpm]
Saving to: “perl-XML-Parser-2.36-7.el6.x86_64.rpm”

100%[=====================================================================================================================================================================>] 229,296     --.-K/s   in 0.1s

2021-01-03 21:41:39 (1.96 MB/s) - “perl-XML-Parser-2.36-7.el6.x86_64.rpm” saved [229296/229296]

[root@mryqulax ~]# wget https://vault.centos.org/6.1/os/x86_64/Packages/perl-XML-Simple-2.18-6.el6.noarch.rpm
--2021-01-03 21:41:57--  https://vault.centos.org/6.1/os/x86_64/Packages/perl-XML-Simple-2.18-6.el6.noarch.rpm
Resolving vault.centos.org... 3.22.185.178, 2600:1f16:c1:5e03:a992:8ee1:99d2:6f8
Connecting to vault.centos.org|3.22.185.178|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 74140 (72K) [application/x-rpm]
Saving to: “perl-XML-Simple-2.18-6.el6.noarch.rpm”

100%[=====================================================================================================================================================================>] 74,140      --.-K/s   in 0.04s

2021-01-03 21:41:57 (1.77 MB/s) - “perl-XML-Simple-2.18-6.el6.noarch.rpm” saved [74140/74140]

[root@mryqulax ~]# wget https://vault.centos.org/6.1/os/x86_64/Packages/perl-XML-LibXML-1.70-5.el6.x86_64.rpm
--2021-01-03 21:42:25--  https://vault.centos.org/6.1/os/x86_64/Packages/perl-XML-LibXML-1.70-5.el6.x86_64.rpm
Resolving vault.centos.org... 54.186.51.210, 2600:1f13:2e7:2901:d2b0:c3b2:9347:934c
Connecting to vault.centos.org|54.186.51.210|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 372868 (364K) [application/x-rpm]
Saving to: “perl-XML-LibXML-1.70-5.el6.x86_64.rpm”

100%[=====================================================================================================================================================================>] 372,868      750K/s   in 0.5s

2021-01-03 21:42:26 (750 KB/s) - “perl-XML-LibXML-1.70-5.el6.x86_64.rpm” saved [372868/372868]

[root@mryqulax ~]# rpm -ivh perl-XML-Parser-2.36-7.el6.x86_64.rpm
warning: perl-XML-Parser-2.36-7.el6.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
Preparing...                ########################################### [100%]
        package perl-XML-Parser-2.36-7.el6.x86_64 is already installed
        file /usr/lib64/perl5/auto/XML/Parser/Expat/Expat.so from install of perl-XML-Parser-2.36-7.el6.x86_64 conflicts with file from package perl-XML-Parser-2.36-7.el6.x86_64
[root@mryqulax ~]# rpm  -ivh perl-XML-Simple-2.18-6.el6.noarch.rpm
warning: perl-XML-Simple-2.18-6.el6.noarch.rpm: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
Preparing...                ########################################### [100%]
   1:perl-XML-Simple        ########################################### [100%]
[root@mryqulax ~]# rpm -ivh perl-XML-LibXML-1.70-5.el6.x86_64.rpm
warning: perl-XML-LibXML-1.70-5.el6.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
error: Failed dependencies:
        perl(XML::NamespaceSupport) is needed by perl-XML-LibXML-1:1.70-5.el6.x86_64
        perl(XML::SAX::Base) is needed by perl-XML-LibXML-1:1.70-5.el6.x86_64
        perl(XML::SAX::DocumentLocator) is needed by perl-XML-LibXML-1:1.70-5.el6.x86_64
        perl(XML::SAX::Exception) is needed by perl-XML-LibXML-1:1.70-5.el6.x86_64
[root@mryqulax ~]# wget https://vault.centos.org/6.1/os/x86_64/Packages/perl-XML-NamespaceSupport-1.10-3.el6.noarch.rpm
--2021-01-03 21:44:15--  https://vault.centos.org/6.1/os/x86_64/Packages/perl-XML-NamespaceSupport-1.10-3.el6.noarch.rpm
Resolving vault.centos.org... 3.22.185.178, 2600:1f16:c1:5e03:a992:8ee1:99d2:6f8
Connecting to vault.centos.org|3.22.185.178|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 17364 (17K) [application/x-rpm]
Saving to: “perl-XML-NamespaceSupport-1.10-3.el6.noarch.rpm”

100%[=====================================================================================================================================================================>] 17,364      --.-K/s   in 0.02s

2021-01-03 21:44:15 (750 KB/s) - “perl-XML-NamespaceSupport-1.10-3.el6.noarch.rpm” saved [17364/17364]

[root@mryqulax ~]# wget https://vault.centos.org/6.1/os/x86_64/Packages/perl-XML-SAX-0.96-7.el6.noarch.rpm
--2021-01-03 21:44:35--  https://vault.centos.org/6.1/os/x86_64/Packages/perl-XML-SAX-0.96-7.el6.noarch.rpm
Resolving vault.centos.org... 3.22.185.178, 2600:1f16:c1:5e03:a992:8ee1:99d2:6f8
Connecting to vault.centos.org|3.22.185.178|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 79664 (78K) [application/x-rpm]
Saving to: “perl-XML-SAX-0.96-7.el6.noarch.rpm”

100%[=====================================================================================================================================================================>] 79,664      --.-K/s   in 0.06s

2021-01-03 21:44:35 (1.27 MB/s) - “perl-XML-SAX-0.96-7.el6.noarch.rpm” saved [79664/79664]

[root@mryqulax ~]# rpm -ivh perl-XML-NamespaceSupport-1.10-3.el6.noarch.rpm
warning: perl-XML-NamespaceSupport-1.10-3.el6.noarch.rpm: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
Preparing...                ########################################### [100%]
   1:perl-XML-NamespaceSuppo########################################### [100%]
[root@mryqulax ~]# rpm -ivh perl-XML-SAX-0.96-7.el6.noarch.rpm
warning: perl-XML-SAX-0.96-7.el6.noarch.rpm: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
error: Failed dependencies:
        perl(XML::LibXML) is needed by perl-XML-SAX-0.96-7.el6.noarch
        perl(XML::LibXML::Common) is needed by perl-XML-SAX-0.96-7.el6.noarch
[root@mryqulax ~]# rpm -ivh perl-XML-LibXML-1.70-5.el6.x86_64.rpm
warning: perl-XML-LibXML-1.70-5.el6.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
error: Failed dependencies:
        perl(XML::SAX::Base) is needed by perl-XML-LibXML-1:1.70-5.el6.x86_64
        perl(XML::SAX::DocumentLocator) is needed by perl-XML-LibXML-1:1.70-5.el6.x86_64
        perl(XML::SAX::Exception) is needed by perl-XML-LibXML-1:1.70-5.el6.x86_64
[root@mryqulax ~]# ls *.rpm
perl-XML-LibXML-1.70-5.el6.x86_64.rpm  perl-XML-SAX-0.96-7.el6.noarch.rpm
[root@mryqulax ~]# ls *.rpm |  xargs rpm -ivh --nodeps
warning: perl-XML-LibXML-1.70-5.el6.x86_64.rpm: Header V3 RSA/SHA256 Signature, key ID c105b9de: NOKEY
Preparing...                ########################################### [100%]
   1:perl-XML-SAX           ########################################### [ 50%]
   2:perl-XML-LibXML        ########################################### [100%]
[root@mryqulax ~]# perldoc -l XML::LibXML
/usr/lib64/perl5/XML/LibXML.pod
```
