Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57323 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751977AbeEGOyZ (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 7 May 2018 10:54:25 -0400
Date: Mon, 7 May 2018 07:54:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: John Crispin <john@phrozen.org>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] watchdog: ath79: fix maximum timeout
Message-ID: <20180507145416.GA14523@roeck-us.net>
References: <20180507131642.11440-1-john@phrozen.org>
 <319719c3-eeec-c75f-68c1-b6d15cf884c5@roeck-us.net>
 <3c24c84f-baa1-2eef-4b5c-85d0e5803e7b@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c24c84f-baa1-2eef-4b5c-85d0e5803e7b@phrozen.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, May 07, 2018 at 03:40:57PM +0200, John Crispin wrote:
> 
> 
> On 07/05/18 15:34, Guenter Roeck wrote:
> >On 05/07/2018 06:16 AM, John Crispin wrote:
> >>If the userland tries to set a timeout higher than the max_timeout,
> >>then we should fallback to max_timeout.
> >>
> >
> >We don't do that for drivers using the watchdog core, so we should not
> >do it here either for consistency.
> >
> >Guenter
> 
> Hi,
> thanks for the quick feedback. I'll mark the patch as "rejected by upstream
> due to subsystem consistency" inside OpenWrt.

Note that I am not completely opposed to the idea, but it should go through
the watchdog core. You could convert the driver to use it, and then make
the case that the subsystem should report <min, max> to userspace, relax
set_timeout to adjust the requested timeout to [min,max] instead of letting
userspace guess it, or both. Plus, of course, submit patches to actually
implement and document the necessary changes.

Thanks,
Guenter
