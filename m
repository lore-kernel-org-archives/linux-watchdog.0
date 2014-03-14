Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:44537 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751946AbaCNR52 (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Mar 2014 13:57:28 -0400
Received: by mail-pa0-f45.google.com with SMTP id kl14so2962032pab.32
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Mar 2014 10:57:28 -0700 (PDT)
Date: Fri, 14 Mar 2014 10:57:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: acquirewdt: Use platform_driver_probe
Message-ID: <20140314175726.GA3868@roeck-us.net>
References: <20140314130437.0774fb75@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140314130437.0774fb75@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 14, 2014 at 01:04:37PM +0100, Jean Delvare wrote:
> Using platform_driver_probe instead of platform_driver_register has
> two benefits:
> * The driver will fail to load if device probing fails.
> * The probe function can be marked __init.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
