Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:53913 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397Ab3FHICn (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Sat, 8 Jun 2013 04:02:43 -0400
Date: Sat, 8 Jun 2013 10:02:39 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Carlo Caione <carlo.caione@gmail.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com,
	henrik@henriknordstrom.net, linux@roeck-us.net
Subject: Re: [PATCH v5] ARM: sunxi: New watchdog driver for Allwinner A10/A13
Message-ID: <20130608080239.GA22632@lukather>
References: <1370547265-24854-1-git-send-email-carlo.caione@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370547265-24854-1-git-send-email-carlo.caione@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Carlo,

On Thu, Jun 06, 2013 at 09:34:25PM +0200, Carlo Caione wrote:
> This patch adds the driver for the watchdog found in the Allwinner A10 and
> A13 SoCs. It has DT-support and uses the new watchdog framework.
> 
> Signed-off-by: Carlo Caione <carlo.caione@gmail.com>

It looks good to me.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks for your work!

Maxime
