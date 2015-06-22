Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:60451 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751436AbbFVQ7k (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 22 Jun 2015 12:59:40 -0400
Date: Mon, 22 Jun 2015 09:59:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: Re: [v2,3/3] watchdog: max63xx: add heartbeat to platform data
Message-ID: <20150622165938.GA1526@roeck-us.net>
References: <1434581940-15086-3-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1434581940-15086-3-git-send-email-vivien.didelot@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Vivien,

On Wed, Jun 17, 2015 at 06:59:00PM -0400, Vivien Didelot wrote:
> Actually, there is no way but the module parameter to set the desired
> heartbeat. This patch allows a platform code to set it in the device
> platform data. This is convenient for platforms and built-in drivers.
> 
> To do so, initialize heartbeat to zero to allow the module parameter to
> take precedence over the platform setting. If not set, it will still
> default to DEFAULT_HEARTBEAT.
> 

I think that warrants a bit of discussion. Is the chip used on an
x86 system (no devicetree), and is there reason to believe that the
default watchdog timeout is not good enough until the watchdog application
starts and can configure it to a different value ?

This is also a bit more complicated since gpio pin 0 can be a valid gpio
pin number, so you'd have to explicitly state "don't use gpio" in the
platform data.

Thanks,
Guenter
--
To unsubscribe from this list: send the line "unsubscribe linux-watchdog" in
