Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from ns1.pc-advies.be ([83.149.101.17]:42733 "EHLO
	spo001.leaseweb.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755973Ab2FZSpL (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 26 Jun 2012 14:45:11 -0400
Date: Tue, 26 Jun 2012 20:45:10 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Tony Zelenoff <antonz@parallels.com>
Cc: linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] iTCO_wdt: move watchdog to proper kernel interface
Message-ID: <20120626184509.GD735@spo001.leaseweb.com>
References: <1339150154-25247-1-git-send-email-antonz@parallels.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1339150154-25247-1-git-send-email-antonz@parallels.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Tony,

> Remove obsoleted fs interface and move to proper usage of
> watchdog_device interface.
> 
> Signed-off-by: Tony Zelenoff <antonz@parallels.com>

Code seems OK, but as I allready told other people: I have allready the code
for converting the iTCO_wdt driver (I tested the generic framework with it).
But I had to stall it because of the lpc_ich conversion.
Anyway: my code is in linux-next now. I will be adding some extra patches in
the coming days also.

Kind regards,
Wim.

