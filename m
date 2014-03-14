Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:53826 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755874AbaCNTvn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Mar 2014 15:51:43 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so3068135pbb.0
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Mar 2014 12:51:43 -0700 (PDT)
Date: Fri, 14 Mar 2014 12:51:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: Fix Elan SC520 dependencies
Message-ID: <20140314195139.GA12030@roeck-us.net>
References: <20140314202529.573208f5@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140314202529.573208f5@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 14, 2014 at 08:25:29PM +0100, Jean Delvare wrote:
> Anyone using a system based on an AMD Elan SC520 processor would be
> building a dedicated kernel for it, so we can make the sc520_wdt
> driver depend on MELAN. SC520_CPUFREQ already depends on MELAN so it
> makes things more consistent. It also makes kernel configuration for
> every other x86 user easier.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
