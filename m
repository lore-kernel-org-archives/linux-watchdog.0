Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:39323 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754461AbaCNR7U (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Mar 2014 13:59:20 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so2841487pdj.37
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Mar 2014 10:59:19 -0700 (PDT)
Date: Fri, 14 Mar 2014 10:59:09 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: geodewdt: Use platform_driver_probe
Message-ID: <20140314175909.GC3868@roeck-us.net>
References: <20140314131647.60c51274@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140314131647.60c51274@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 14, 2014 at 01:16:47PM +0100, Jean Delvare wrote:
> Using platform_driver_probe instead of platform_driver_register has
> two benefits:
> * The driver will fail to load if device probing fails.
> * The probe function can be marked __init.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
