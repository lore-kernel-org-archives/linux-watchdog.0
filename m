Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:39704 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753591AbcJTW2i (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Thu, 20 Oct 2016 18:28:38 -0400
Date: Thu, 20 Oct 2016 15:28:33 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Kevin Hilman <khilman@baylibre.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] watchdog: meson: Remove unneeded platform MODULE_ALIAS
Message-ID: <20161020222833.GA27421@roeck-us.net>
References: <1476906582-14241-1-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476906582-14241-1-git-send-email-javier@osg.samsung.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 19, 2016 at 04:49:42PM -0300, Javier Martinez Canillas wrote:
> The Amlogic Meson is a DT-only platform, which means the devices are
> registered via OF and not using the legacy platform devices support.
> 
> So there's no need to have a MODULE_ALIAS("platform:meson-gxbb-wdt")
> since the reported uevent MODALIAS to user-space will be the OF one.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
