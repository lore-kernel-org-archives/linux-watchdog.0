Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48575 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754134Ab3KLPjd (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Nov 2013 10:39:33 -0500
Message-ID: <52824B93.2090201@ti.com>
Date: Tue, 12 Nov 2013 10:38:59 -0500
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
MIME-Version: 1.0
To: "ivan.khoronzhuk" <ivan.khoronzhuk@ti.com>
CC: <wim@iguana.be>, <nsekhar@ti.com>,
	<linux-watchdog@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<grant.likely@linaro.org>, <rob.herring@calxeda.com>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<swarren@wwwdotorg.org>, <galak@kernel.crashing.org>,
	<ijc+devicetree@hellion.org.uk>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: Fwd: [PATCH 5/8] watchdog: davinci: add "timeout-sec" property
References: <1383680783-12114-6-git-send-email-ivan.khoronzhuk@ti.com> <527A28D8.9040901@ti.com>
In-Reply-To: <527A28D8.9040901@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wednesday 06 November 2013 06:32 AM, ivan.khoronzhuk wrote:
> Since Davinci WDT has been switched to use WDT core, it became able
> to support timeout-sec property, so add it to it's binding description.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

