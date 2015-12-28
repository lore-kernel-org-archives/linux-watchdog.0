Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:43961 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752534AbbL1WPM (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 28 Dec 2015 17:15:12 -0500
Date: Mon, 28 Dec 2015 23:15:10 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-watchdog@vger.kernel.org,
	Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] watchdog: Do not use 'dev' from watchdog_device in watchdog drivers
Message-ID: <20151228221510.GB1889@spo001.leaseweb.nl>
References: <1450995724-17758-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1450995724-17758-1-git-send-email-linux@roeck-us.net>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Guenter,

> The 'dev' variable in watchdog drivers has a different lifetime than the
> watchdog character device and should therefore not be used by watchdog
> drivers.
> 
> Some of the drivers use the variable to print kernel messages. Those
> messages are either dropped or changed to use the parent device.
> One driver sets the variable during initialization to the watchdog
> driver's parent device, which is wrong and was removed.
> 
> v2: Use parent device for dev_XXX messages instead of pr_XXX.

This patchset has been added to linux-watchdog-next.

Kind regards,
Wim.

