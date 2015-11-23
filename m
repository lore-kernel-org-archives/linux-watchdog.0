Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:51125 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840AbbKWPUg (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Nov 2015 10:20:36 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	robh+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
	wim@iguana.be, sameo@linux.intel.com, dinh.linux@gmail.com,
	linux@roeck-us.net, kernel@savoirfairelinux.com
Subject: Re: [PATCH v4 2/5] mfd: syscon: add a DT property to set value width
Date: Mon, 23 Nov 2015 16:19:30 +0100
Message-ID: <4954077.yFyHuebvEs@wuerfel>
In-Reply-To: <1448291861-28543-3-git-send-email-damien.riegel@savoirfairelinux.com>
References: <1448291861-28543-1-git-send-email-damien.riegel@savoirfairelinux.com> <1448291861-28543-3-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Monday 23 November 2015 10:17:38 Damien Riegel wrote:
> Currently syscon has a fixed configuration of 32 bits for register and
> values widths. In some cases, it would be desirable to be able to
> customize the value width.
> 
> For example, certain boards (like the ones manufactured by Technologic
> Systems) have a FPGA that is memory-mapped, but its registers are only
> 16-bit wide.
> 
> This patch adds an optional "bus-width" DT binding for syscon that
> allows to change the width for the data bus (i.e. val_bits). If this
> property is provided, it will also adjust the register stride to
> bus-width / 8. If not provided, the default configuration is used.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
