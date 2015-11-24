Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:36762 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428AbbKXSIe (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 24 Nov 2015 13:08:34 -0500
Date: Tue, 24 Nov 2015 10:08:28 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
	robh+dt@kernel.org, shawnguo@kernel.org, kernel@pengutronix.de,
	wim@iguana.be, sameo@linux.intel.com, dinh.linux@gmail.com,
	Arnd Bergmann <arnd@arndb.de>, kernel@savoirfairelinux.com
Subject: Re: [PATCH v5 3/5] watchdog: ts4800: add driver for TS-4800 watchdog
Message-ID: <20151124180828.GA11719@roeck-us.net>
References: <1448388053-30661-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1448388053-30661-4-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1448388053-30661-4-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tue, Nov 24, 2015 at 01:00:51PM -0500, Damien Riegel wrote:
> This watchdog is instantiated in a FPGA that is memory mapped. It is
> made of only one register, called the feed register. Writing to this
> register will re-arm the watchdog for a given time (and enable it if it
> was disable). It can be disabled by writing a special value into it.
> 
> It is part of a syscon block, and the watchdog register offset in this
> block varies from board to board. This offset is passed in the syscon
> property after the phandle to the syscon node.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
