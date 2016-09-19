Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from resqmta-po-05v.sys.comcast.net ([96.114.154.164]:49682 "EHLO
        resqmta-po-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750800AbcISOrr (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 19 Sep 2016 10:47:47 -0400
From: Shuah Khan <shuahkh@osg.samsung.com>
To: corbet@lwn.net, sudeep.dutt@intel.com, ashutosh.dixit@intel.com,
        tomas.winkler@intel.com, tglx@linutronix.de, wim@iguana.be,
        linux@roeck-us.net, elfring@users.sourceforge.net,
        nicolas.dichtel@6wind.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, dasaratharaman.chandramouli@intel.com,
        maheshkhanwalkar@gmail.com, mikedanese@google.com,
        ben@decadent.org.uk, ghackmann@google.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org,
        linux-watchdog@vger.kernel.org
Subject: [PATCH 0/8] Move runnable examples code from Documentation to samples
Date: Mon, 19 Sep 2016 08:47:31 -0600
Message-Id: <cover.1474073857.git.shuahkh@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Move runnable examples code from Documentation to samples. I moved
just the example code, and left documentation files as is.

blackfin gptimers example code needs a bit of special handling since
it is a module. I will address it in a separate patch. 00-Index files
need to be updated due to this move which will be done another patch.

Shuah Khan (8):
  samples: move accounting example code from Documentation
  samples: move auxdisplay example code from Documentation
  samples: move laptops example code from Documentation
  samples: move mic/mpssd example code from Documentation
  samples: move misc-devices/mei example code from Documentation
  samples: move pcmcia example code from Documentation
  samples: move timers example code from Documentation
  samples: move watchdog example code from Documentation

 Documentation/Makefile                           |    3 +-
 Documentation/accounting/.gitignore              |    1 -
 Documentation/accounting/Makefile                |    7 -
 Documentation/accounting/getdelays.c             |  550 -------
 Documentation/auxdisplay/.gitignore              |    1 -
 Documentation/auxdisplay/Makefile                |    7 -
 Documentation/auxdisplay/cfag12864b-example.c    |  281 ----
 Documentation/laptops/.gitignore                 |    1 -
 Documentation/laptops/Makefile                   |    5 -
 Documentation/laptops/dslm.c                     |  166 --
 Documentation/mic/Makefile                       |    1 -
 Documentation/mic/mpssd/.gitignore               |    1 -
 Documentation/mic/mpssd/Makefile                 |   21 -
 Documentation/mic/mpssd/micctrl                  |  173 --
 Documentation/mic/mpssd/mpss                     |  200 ---
 Documentation/mic/mpssd/mpssd.c                  | 1826 ----------------------
 Documentation/mic/mpssd/mpssd.h                  |  103 --
 Documentation/mic/mpssd/sysfs.c                  |  102 --
 Documentation/misc-devices/Makefile              |    1 -
 Documentation/misc-devices/mei/.gitignore        |    1 -
 Documentation/misc-devices/mei/Makefile          |    5 -
 Documentation/misc-devices/mei/TODO              |    2 -
 Documentation/misc-devices/mei/mei-amt-version.c |  479 ------
 Documentation/pcmcia/.gitignore                  |    1 -
 Documentation/pcmcia/Makefile                    |    7 -
 Documentation/pcmcia/crc32hash.c                 |   32 -
 Documentation/timers/.gitignore                  |    1 -
 Documentation/timers/Makefile                    |    5 -
 Documentation/timers/hpet_example.c              |  294 ----
 Documentation/watchdog/Makefile                  |    1 -
 Documentation/watchdog/src/.gitignore            |    1 -
 Documentation/watchdog/src/Makefile              |    5 -
 Documentation/watchdog/src/watchdog-simple.c     |   24 -
 samples/accounting/.gitignore                    |    1 +
 samples/accounting/Makefile                      |    9 +
 samples/accounting/getdelays.c                   |  550 +++++++
 samples/auxdisplay/.gitignore                    |    1 +
 samples/auxdisplay/Makefile                      |    9 +
 samples/auxdisplay/cfag12864b-example.c          |  281 ++++
 samples/laptops/.gitignore                       |    1 +
 samples/laptops/Makefile                         |    9 +
 samples/laptops/dslm.c                           |  166 ++
 samples/mei/.gitignore                           |    1 +
 samples/mei/Makefile                             |    9 +
 samples/mei/TODO                                 |    2 +
 samples/mei/mei-amt-version.c                    |  479 ++++++
 samples/mic/mpssd/.gitignore                     |    1 +
 samples/mic/mpssd/Makefile                       |   27 +
 samples/mic/mpssd/micctrl                        |  173 ++
 samples/mic/mpssd/mpss                           |  200 +++
 samples/mic/mpssd/mpssd.c                        | 1826 ++++++++++++++++++++++
 samples/mic/mpssd/mpssd.h                        |  103 ++
 samples/mic/mpssd/sysfs.c                        |  102 ++
 samples/pcmcia/.gitignore                        |    1 +
 samples/pcmcia/Makefile                          |    9 +
 samples/pcmcia/crc32hash.c                       |   32 +
 samples/timers/.gitignore                        |    1 +
 samples/timers/Makefile                          |   15 +
 samples/timers/hpet_example.c                    |  294 ++++
 samples/watchdog/.gitignore                      |    1 +
 samples/watchdog/Makefile                        |    8 +
 samples/watchdog/watchdog-simple.c               |   24 +
 62 files changed, 4336 insertions(+), 4307 deletions(-)
 delete mode 100644 Documentation/accounting/.gitignore
 delete mode 100644 Documentation/accounting/Makefile
 delete mode 100644 Documentation/accounting/getdelays.c
 delete mode 100644 Documentation/auxdisplay/.gitignore
 delete mode 100644 Documentation/auxdisplay/Makefile
 delete mode 100644 Documentation/auxdisplay/cfag12864b-example.c
 delete mode 100644 Documentation/laptops/.gitignore
 delete mode 100644 Documentation/laptops/Makefile
 delete mode 100644 Documentation/laptops/dslm.c
 delete mode 100644 Documentation/mic/Makefile
 delete mode 100644 Documentation/mic/mpssd/.gitignore
 delete mode 100644 Documentation/mic/mpssd/Makefile
 delete mode 100755 Documentation/mic/mpssd/micctrl
 delete mode 100755 Documentation/mic/mpssd/mpss
 delete mode 100644 Documentation/mic/mpssd/mpssd.c
 delete mode 100644 Documentation/mic/mpssd/mpssd.h
 delete mode 100644 Documentation/mic/mpssd/sysfs.c
 delete mode 100644 Documentation/misc-devices/Makefile
 delete mode 100644 Documentation/misc-devices/mei/.gitignore
 delete mode 100644 Documentation/misc-devices/mei/Makefile
 delete mode 100644 Documentation/misc-devices/mei/TODO
 delete mode 100644 Documentation/misc-devices/mei/mei-amt-version.c
 delete mode 100644 Documentation/pcmcia/.gitignore
 delete mode 100644 Documentation/pcmcia/Makefile
 delete mode 100644 Documentation/pcmcia/crc32hash.c
 delete mode 100644 Documentation/timers/.gitignore
 delete mode 100644 Documentation/timers/Makefile
 delete mode 100644 Documentation/timers/hpet_example.c
 delete mode 100644 Documentation/watchdog/Makefile
 delete mode 100644 Documentation/watchdog/src/.gitignore
 delete mode 100644 Documentation/watchdog/src/Makefile
 delete mode 100644 Documentation/watchdog/src/watchdog-simple.c
 create mode 100644 samples/accounting/.gitignore
 create mode 100644 samples/accounting/Makefile
 create mode 100644 samples/accounting/getdelays.c
 create mode 100644 samples/auxdisplay/.gitignore
 create mode 100644 samples/auxdisplay/Makefile
 create mode 100644 samples/auxdisplay/cfag12864b-example.c
 create mode 100644 samples/laptops/.gitignore
 create mode 100644 samples/laptops/Makefile
 create mode 100644 samples/laptops/dslm.c
 create mode 100644 samples/mei/.gitignore
 create mode 100644 samples/mei/Makefile
 create mode 100644 samples/mei/TODO
 create mode 100644 samples/mei/mei-amt-version.c
 create mode 100644 samples/mic/mpssd/.gitignore
 create mode 100644 samples/mic/mpssd/Makefile
 create mode 100755 samples/mic/mpssd/micctrl
 create mode 100755 samples/mic/mpssd/mpss
 create mode 100644 samples/mic/mpssd/mpssd.c
 create mode 100644 samples/mic/mpssd/mpssd.h
 create mode 100644 samples/mic/mpssd/sysfs.c
 create mode 100644 samples/pcmcia/.gitignore
 create mode 100644 samples/pcmcia/Makefile
 create mode 100644 samples/pcmcia/crc32hash.c
 create mode 100644 samples/timers/.gitignore
 create mode 100644 samples/timers/Makefile
 create mode 100644 samples/timers/hpet_example.c
 create mode 100644 samples/watchdog/.gitignore
 create mode 100644 samples/watchdog/Makefile
 create mode 100644 samples/watchdog/watchdog-simple.c

-- 
2.7.4

