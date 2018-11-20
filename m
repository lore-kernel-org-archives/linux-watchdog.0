Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44472 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeKUCzn (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 20 Nov 2018 21:55:43 -0500
Date: Tue, 20 Nov 2018 08:25:43 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-watchdog@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-doc@vger.kernel.org, Jim Cromie <jim.cromie@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Brian Norris <computersforpeace@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        David Woodhouse <dwmw2@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] kbuild: announce removal of SUBDIRS if used
Message-ID: <20181120162543.GB4765@roeck-us.net>
References: <1542726258-8418-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542726258-8418-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Nov 21, 2018 at 12:04:18AM +0900, Masahiro Yamada wrote:
> SUBDIRS has been kept as a backward compatibility since
> commit ("[PATCH] kbuild: external module support") in 2002.
> 
> We do not need multiple ways to do the same thing, so I will remove
> SUBDIRS after the Linux 5.3 release. I cleaned up in-tree code, and
> updated the document so that nobody would try to use it.
> 
> Meanwhile, display the following warning if SUBDIRS is used.
> 
> Makefile:189: ================= WARNING ================
> Makefile:190: 'SUBDIRS' will be removed after Linux 5.3
> Makefile:191: Please use 'M=' or 'KBUILD_EXTMOD' instead
> Makefile:192: ==========================================
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
>  Documentation/kbuild/kbuild.txt    | 7 +------
>  Makefile                           | 4 ++++
>  drivers/mtd/maps/scx200_docflash.c | 7 -------
>  drivers/watchdog/scx200_wdt.c      | 7 -------

For watchdog:

Acked-by: Guenter Roeck <linux@roeck-us.net>

>  samples/connector/Makefile         | 2 +-
>  5 files changed, 6 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/kbuild/kbuild.txt b/Documentation/kbuild/kbuild.txt
> index 8390c36..c9e3d93 100644
> --- a/Documentation/kbuild/kbuild.txt
> +++ b/Documentation/kbuild/kbuild.txt
> @@ -81,12 +81,7 @@ KBUILD_EXTMOD
>  --------------------------------------------------
>  Set the directory to look for the kernel source when building external
>  modules.
> -The directory can be specified in several ways:
> -1) Use "M=..." on the command line
> -2) Environment variable KBUILD_EXTMOD
> -3) Environment variable SUBDIRS
> -The possibilities are listed in the order they take precedence.
> -Using "M=..." will always override the others.
> +Setting "M=..." takes precedence over KBUILD_EXTMOD.
>  
>  KBUILD_OUTPUT
>  --------------------------------------------------
> diff --git a/Makefile b/Makefile
> index 370d13b..57be5fb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -186,6 +186,10 @@ endif
>  # Old syntax make ... SUBDIRS=$PWD is still supported
>  # Setting the environment variable KBUILD_EXTMOD take precedence
>  ifdef SUBDIRS
> +  $(warning ================= WARNING ================)
> +  $(warning 'SUBDIRS' will be removed after Linux 5.3)
> +  $(warning Please use 'M=' or 'KBUILD_EXTMOD' instead)
> +  $(warning ==========================================)
>    KBUILD_EXTMOD ?= $(SUBDIRS)
>  endif
>  
> diff --git a/drivers/mtd/maps/scx200_docflash.c b/drivers/mtd/maps/scx200_docflash.c
> index f1c1f73..7f1a0e6 100644
> --- a/drivers/mtd/maps/scx200_docflash.c
> +++ b/drivers/mtd/maps/scx200_docflash.c
> @@ -216,10 +216,3 @@ static void __exit cleanup_scx200_docflash(void)
>  
>  module_init(init_scx200_docflash);
>  module_exit(cleanup_scx200_docflash);
> -
> -/*
> -    Local variables:
> -        compile-command: "make -k -C ../../.. SUBDIRS=drivers/mtd/maps modules"
> -        c-basic-offset: 8
> -    End:
> -*/
> diff --git a/drivers/watchdog/scx200_wdt.c b/drivers/watchdog/scx200_wdt.c
> index 836377c..ec4063e 100644
> --- a/drivers/watchdog/scx200_wdt.c
> +++ b/drivers/watchdog/scx200_wdt.c
> @@ -262,10 +262,3 @@ static void __exit scx200_wdt_cleanup(void)
>  
>  module_init(scx200_wdt_init);
>  module_exit(scx200_wdt_cleanup);
> -
> -/*
> -    Local variables:
> -	compile-command: "make -k -C ../.. SUBDIRS=drivers/char modules"
> -	c-basic-offset: 8
> -    End:
> -*/
> diff --git a/samples/connector/Makefile b/samples/connector/Makefile
> index fe3c854..6ad7162 100644
> --- a/samples/connector/Makefile
> +++ b/samples/connector/Makefile
> @@ -14,4 +14,4 @@ HOSTCFLAGS_ucon.o += -I$(objtree)/usr/include
>  all: modules
>  
>  modules clean:
> -	$(MAKE) -C ../.. SUBDIRS=$(CURDIR) $@
> +	$(MAKE) -C ../.. M=$(CURDIR) $@
> -- 
> 2.7.4
> 
