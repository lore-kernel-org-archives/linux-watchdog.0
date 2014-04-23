Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.131]:50188 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458AbaDWP7L (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 23 Apr 2014 11:59:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, wim@iguana.be,
	dbaryshkov@gmail.com, dwmw2@infradead.org,
	linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/5] power: reset: Add Allwinner A31 reset code
Date: Wed, 23 Apr 2014 17:58:20 +0200
Message-ID: <8237209.ZduvMhRroZ@wuerfel>
In-Reply-To: <1398265476-29373-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1398265476-29373-1-git-send-email-maxime.ripard@free-electrons.com> <1398265476-29373-3-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wednesday 23 April 2014 17:04:33 Maxime Ripard wrote:
> That code used to be in the machine code, but it's more fit here with other
> restart hooks.
> 
> That will allow to cleanup the machine directory, while waiting for a proper
> watchdog driver for the A31.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>
