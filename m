Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:37813 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935206Ab2JYTJv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 25 Oct 2012 15:09:51 -0400
Date: Thu, 25 Oct 2012 19:09:50 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Tony Lindgren <tony@atomide.com>
cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 5/7] ARM: OMAP2+: WDT: move init; add read_reset_sources
 pdata function pointer
In-Reply-To: <20121025185755.GV11928@atomide.com>
Message-ID: <alpine.DEB.2.00.1210251908560.21193@utopia.booyaka.com>
References: <20121016012448.21844.92339.stgit@dusk.lan> <20121016013213.21844.20016.stgit@dusk.lan> <20121025153805.GB11623@blackmetal.musicnaut.iki.fi> <alpine.DEB.2.00.1210251846130.21193@utopia.booyaka.com> <20121025185755.GV11928@atomide.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 25 Oct 2012, Tony Lindgren wrote:

> Ideally we'd have some Linux generic function to implement in the PRM/CM
> drivers for getting the bootreason. But I guess we don't?

Do you know of one, apart from WDIOC_GETBOOTSTATUS?


- Paul
