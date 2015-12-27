Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43613 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750918AbbL0Q6B (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sun, 27 Dec 2015 11:58:01 -0500
Date: Sun, 27 Dec 2015 17:57:56 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Pratyush Anand <panand@redhat.com>
Cc: dyoung@redhat.com, dzickus@redhat.com, linux@roeck-us.net,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V5 0/2] watchdog: Sysfs status read support
Message-ID: <20151227165756.GC23719@spo001.leaseweb.nl>
References: <cover.1450353452.git.panand@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1450353452.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Pratyush,

> These patches provide support to read different watchdog device status
> through sysfs interface.
>  
> Changes since V4:
> * All sysfs code has been protected under CONFIG_WATCHDOG_SYSFS
> 
> Changes since V3:                                                                                    
> * Added Reviewed by tag
> * Corrected a checkpatch warning             
> 
> Changes since V2: 
> * Used static struct class watchdog_class in stead of pointer. It helped to 
> keep using device_create(). 
> * Above logic was moved to a separate patch.  Changed subject line of other
> patch to look more relevant  
> 
> Changes since V1(RFC): 
> * Removed keepalive and start ABI
> * timeout is read only now
> * state returns text
> * only supported ABI visible
> * ABI contact changed to MAINTAINER
> * unnecessary mutex removed
> * aligned continuation with '('
> * unnecessary initialization of status (= 0) corrected
> * unnecessary else removed
> * used __ATTRIBUTE_GROUPS
> * removed watchdog_device_create and added functionality in
> * watchdog_dev_register.
> * optimized nowayout_show
> * Now no -EOPNOTSUPP return for timeout read in case of
> * wdd->timeout = 0.         
> 
> Pratyush Anand (2):
>   watchdog: Use static struct class watchdog_class in stead of pointer
>   watchdog: Read device status through sysfs attributes
> 
>  Documentation/ABI/testing/sysfs-class-watchdog |  51 +++++++++
>  drivers/watchdog/Kconfig                       |   7 ++
>  drivers/watchdog/watchdog_core.c               |  17 +--
>  drivers/watchdog/watchdog_core.h               |   2 +-
>  drivers/watchdog/watchdog_dev.c                | 140 ++++++++++++++++++++++++-
>  5 files changed, 198 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-watchdog

This patchset has been added to linux-watchdog-next.
The second patch has been altered as suggested by Guenter (with the #else ; #define wdt_groups NULL statements).

Kind regards,
Wim.

