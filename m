Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([74.50.51.50]:38111 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992577Ab2JYVJf (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 25 Oct 2012 17:09:35 -0400
Date: Thu, 25 Oct 2012 21:09:35 +0000 (UTC)
From: Paul Walmsley <paul@pwsan.com>
To: Felipe Balbi <balbi@ti.com>
cc: Jon Hunter <jon-hunter@ti.com>, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 6/7] watchdog: OMAP: use standard GETBOOTSTATUS interface;
 use platform_data fn ptr
In-Reply-To: <20121025205926.GA19439@arwen.pp.htv.fi>
Message-ID: <alpine.DEB.2.00.1210252109190.4745@utopia.booyaka.com>
References: <20121016012448.21844.92339.stgit@dusk.lan> <20121016013233.21844.1279.stgit@dusk.lan> <50899DB9.8050308@ti.com> <alpine.DEB.2.00.1210252015490.21193@utopia.booyaka.com> <alpine.DEB.2.00.1210252028330.21193@utopia.booyaka.com>
 <20121025205926.GA19439@arwen.pp.htv.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Thu, 25 Oct 2012, Felipe Balbi wrote:

> should be "exported functions from those drivers directly."

Thanks, will update the patch description.


- Paul
