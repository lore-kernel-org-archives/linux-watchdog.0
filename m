Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.savoirfairelinux.com ([209.172.62.77]:64304 "EHLO
	mail.savoirfairelinux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbDPQou (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 16 Apr 2015 12:44:50 -0400
Date: Thu, 16 Apr 2015 12:37:53 -0400 (EDT)
From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
To: linux-watchdog@vger.kernel.org
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-kernel@vger.kernel.org,
	kernel@savoirfairelinux.com, Guenter Roeck <linux@roeck-us.net>
Message-ID: <1716840274.614850.1429202273466.JavaMail.zimbra@savoirfairelinux.com>
In-Reply-To: <1422551745-29101-1-git-send-email-vivien.didelot@savoirfairelinux.com>
References: <1422551745-29101-1-git-send-email-vivien.didelot@savoirfairelinux.com>
Subject: Re: [PATCH 0/4] watchdog: MAX63xx cleanup and platform settings
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Wim, all,

> The purpose of this patchset is to add a platform data structure for the
> max63xx_wdt driver in order to setup the device in a platform code. This is
> especially handy if the driver is built-in and/or the device registers aren't
> memory mapped.
> 
> First, fix the Kconfig entry to allow building the support for architectures
> other than ARM. Then clean up the driver to help distinguish different device
> connections and to ease the introduction of new features: support for GPIO
> wired MAX63xx devices and heartbeat as a platform setting.
> 
> Tested with a GPIO wired MAX6373 on an Atom platform, with a built-in driver.
> 
> Vivien Didelot (4):
>   watchdog: MAX63XX_WATCHDOG does not depend on ARM
>   watchdog: max63xx: cleanup
>   watchdog: max63xx: add GPIO support
>   watchdog: max63xx: add heartbeat to platform data

Did you get any chance to look into merging this patchset?
(It still applies well on the latest watchdog-next/master tree.)

Best,
-v
