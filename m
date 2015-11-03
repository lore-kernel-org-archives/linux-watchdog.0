Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:56973 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbKCKtj (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Nov 2015 05:49:39 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Lee Jones <lee.jones@linaro.org>
Cc: Damien Riegel <damien.riegel@savoirfairelinux.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-watchdog@vger.kernel.org, shawnguo@kernel.org,
	kernel@pengutronix.de, wim@iguana.be, robh+dt@kernel.org,
	sameo@linux.intel.com, dinh.linux@gmail.com, linux@roeck-us.net,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 2/5] mfd: ts4800-syscon: add driver for TS-4800 syscon
Date: Tue, 03 Nov 2015 11:48:38 +0100
Message-ID: <5597828.MPo2kL1TSa@wuerfel>
In-Reply-To: <20151103101217.GE3503@x1>
References: <1446150450-22093-1-git-send-email-damien.riegel@savoirfairelinux.com> <4911273.Q2mbQ2gvpn@wuerfel> <20151103101217.GE3503@x1>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Tuesday 03 November 2015 10:12:17 Lee Jones wrote:
> > 
> > I think a 'buswidth=<16>;' property in addition to 'compatible="syscon"'
> > is more in line with what other subsystems do.
> 
> Perfect.
> 

Just to clarify: I just checked the other DT bindings and it should
actually be "bus-width", not "buswidth".

	Arnd
