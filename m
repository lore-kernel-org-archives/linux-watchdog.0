Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pb0-f43.google.com ([209.85.160.43]:61454 "EHLO
	mail-pb0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754090AbaCNSAL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Mar 2014 14:00:11 -0400
Received: by mail-pb0-f43.google.com with SMTP id um1so2938168pbc.2
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Mar 2014 11:00:10 -0700 (PDT)
Date: Fri, 14 Mar 2014 11:00:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: ib700wdt: Use platform_driver_probe
Message-ID: <20140314180008.GD3868@roeck-us.net>
References: <20140314131847.5e27fe11@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140314131847.5e27fe11@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 14, 2014 at 01:18:47PM +0100, Jean Delvare wrote:
> Using platform_driver_probe instead of platform_driver_register has
> two benefits:
> * The driver will fail to load if device probing fails.
> * The probe function can be marked __init.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
