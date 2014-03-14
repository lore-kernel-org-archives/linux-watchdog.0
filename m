Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:47280 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755154AbaCNR6R (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 14 Mar 2014 13:58:17 -0400
Received: by mail-pd0-f174.google.com with SMTP id y13so2823408pdi.5
        for <linux-watchdog@vger.kernel.org>; Fri, 14 Mar 2014 10:58:16 -0700 (PDT)
Date: Fri, 14 Mar 2014 10:58:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Jean Delvare <jdelvare@suse.de>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>
Subject: Re: [PATCH] watchdog: advantechwdt: Use platform_driver_probe
Message-ID: <20140314175813.GB3868@roeck-us.net>
References: <20140314130740.15e2465d@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140314130740.15e2465d@endymion.delvare>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Mar 14, 2014 at 01:07:40PM +0100, Jean Delvare wrote:
> Using platform_driver_probe instead of platform_driver_register has
> two benefits:
> * The driver will fail to load if device probing fails.
> * The probe function can be marked __init.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Wim Van Sebroeck <wim@iguana.be>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
