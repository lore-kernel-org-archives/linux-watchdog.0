Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:45262 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754640Ab2F1S6j (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 28 Jun 2012 14:58:39 -0400
Date: Thu, 28 Jun 2012 20:58:38 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: iTCO_wdt depends on watchdog core
Message-ID: <20120628185838.GL735@spo001.leaseweb.com>
References: <1340878789-23759-1-git-send-email-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1340878789-23759-1-git-send-email-heikki.krogerus@linux.intel.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Heikki,

> Since the iTCO_wdt watchdog driver now uses the generic
> watchdog framework, it needs to select it.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Correct. When I wanted to apply this patch, I saw that I messed up my patch
into 2 patches. So I merged the 3 patches to 1 patch.

Kind regards,
Wim.

