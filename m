Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:55635 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752345Ab2EXUyd (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 24 May 2012 16:54:33 -0400
Date: Thu, 24 May 2012 22:54:27 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-watchdog@vger.kernel.org,
	LM Sensors <lm-sensors@lm-sensors.org>,
	linux-next@vger.kernel.org
Subject: Re: [PATCH] hwmon/sch56xx: Depend on watchdog for watchdog core functions
Message-ID: <20120524205426.GW3074@spo001.leaseweb.com>
References: <1337890738-26533-1-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1337890738-26533-1-git-send-email-hdegoede@redhat.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Hans,

> Since the watchdog code in sch56xx-common now uses the watchdog core, the
> Kconfig entires for the sch5627 and sch5636 should depend on WATCHDOG
> being set.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I added also the "select WATCHDOG_CORE" lines for both drivers.
In linux-watchdog-next now.

Kind regards,
Wim.

