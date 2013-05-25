Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:45987 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755817Ab3EYMLN (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 25 May 2013 08:11:13 -0400
Date: Sat, 25 May 2013 14:11:11 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Carlo Caione <carlo.caione@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
	henrik@henriknordstrom.net
Subject: Re: [PATCH v3] ARM: sunxi: New watchdog driver for Allwinner A10/A13
Message-ID: <20130525121111.GC17847@lukather>
References: <1369479567-15104-1-git-send-email-carlo.caione@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1369479567-15104-1-git-send-email-carlo.caione@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Carlo,

On Sat, May 25, 2013 at 12:59:27PM +0200, Carlo Caione wrote:
> This patch adds the driver for the watchdog found in the Allwinner A10 and
> A13 SoCs. It has DT-support and uses the new watchdog framework.
> 
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>

It looks good to me.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
