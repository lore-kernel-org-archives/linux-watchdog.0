Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:42376 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758738AbaJaNGo (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 31 Oct 2014 09:06:44 -0400
Date: Fri, 31 Oct 2014 14:06:30 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wim Van Sebroeck <wim@iguana.be>,
	<linux-watchdog@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	Nadav Haklai <nadavh@marvell.com>,
	Tawfik Bayouk <tawfik@marvell.com>,
	Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 4/4] ARM: mvebu: Enable the reference clock for timer
 and watchdog on Armada 375 SoC
Message-ID: <20141031140630.1d6d5067@free-electrons.com>
In-Reply-To: <1414248522-16055-5-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1414248522-16055-1-git-send-email-ezequiel.garcia@free-electrons.com>
	<1414248522-16055-5-git-send-email-ezequiel.garcia@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Dear Ezequiel Garcia,

On Sat, 25 Oct 2014 11:48:42 -0300, Ezequiel Garcia wrote:
> Now that the timer and watchdog drivers support the Armada 375 usage of
> the reference clock, we can enable it in the devicetree.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
>  arch/arm/boot/dts/armada-375.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
