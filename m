Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56442 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342AbbJFGnG (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 6 Oct 2015 02:43:06 -0400
Date: Tue, 6 Oct 2015 12:13:02 +0530
From: Pratyush Anand <panand@redhat.com>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: dyoung@redhat.com, dzickus@redhat.com,
	linux-watchdog@vger.kernel.org, linux@roeck-us.net
Subject: Re: [PATCH V4 0/2] watchdog: Sysfs status read support
Message-ID: <20151006064302.GA28829@dhcppc13.redhat.com>
References: <cover.1441599217.git.panand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1441599217.git.panand@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim,

I did not see it in v4.3-rc3 Fixes.
This has already been reviewed by Guenter.
Please let me know if I need to do anything more around it.

~Pratyush

On 07/09/2015:09:54:50 AM, Pratyush Anand wrote:
> These patches provide support to read different watchdog device status
> through sysfs interface.
> 
> Changes since V3:
> * Added Reviewed by tag
> * Corrected a checkpatch warning
> 
> Changes since V2:
> * Used static struct class watchdog_class in stead of pointer. It helped in
>  keep using device_create().
> * Above logic was moved to a separate patch.
> * Changed subject line of other patch to look more relevant
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
> * Now no -EOPNOTSUPP return for timeout read in case of wdd->timeout = 0.
> 
> Pratyush Anand (2):
>   watchdog: Use static struct class watchdog_class in stead of pointer
>   watchdog: Read device status through sysfs attributes
> 
>  Documentation/ABI/testing/sysfs-class-watchdog |  51 ++++++++++
>  drivers/watchdog/watchdog_core.c               |  17 +---
>  drivers/watchdog/watchdog_core.h               |   2 +-
>  drivers/watchdog/watchdog_dev.c                | 136 ++++++++++++++++++++++++-
>  4 files changed, 187 insertions(+), 19 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-watchdog
> 
> -- 
> 2.5.0
