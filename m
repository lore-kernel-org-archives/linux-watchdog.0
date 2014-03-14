Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40384 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754676AbaCNSEH (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Mar 2014 14:04:07 -0400
Received: by mail-pa0-f51.google.com with SMTP id kq14so2963355pab.38
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Mar 2014 11:04:06 -0700 (PDT)
Date: Fri, 14 Mar 2014 11:04:03 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org, Zwane Mwaikambo <zwanem@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: Fix SC1200 dependencies
Message-ID: <20140314180403.GE3868@roeck-us.net>
References: <20140314160728.5abc3f4b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140314160728.5abc3f4b@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 14, 2014 at 04:07:28PM +0100, Jean Delvare wrote:
> The SC1200 is a SoC based on the Geode GX1 32-bit x86 processor, so
> its drivers are only needed on this architecture.
> 
The driver is named SC1200, but isn't really SC1200 specific but 
supports the PC87307/PC97307. Not really sure if it is good idea
to remove support for it from 64 bit images. Can we say for sure
that there are no 64 bit systems using this chip ?

Thanks,
Guenter
