Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from spo001.leaseweb.nl ([83.149.101.17]:59077 "EHLO
	spo001.leaseweb.nl" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S933846AbbBCMyq (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 3 Feb 2015 07:54:46 -0500
Date: Tue, 3 Feb 2015 13:54:42 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] gpio_wdt: Add "always_running" feature to GPIO watchdog
Message-ID: <20150203125442.GA26544@spo001.leaseweb.nl>
References: <20150113215212.GA12804@roeck-us.net> <1421216909-3109-1-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1421216909-3109-1-git-send-email-mike.looijmans@topic.nl>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi Mike,

> On some chips, like the TPS386000, the trigger cannot be disabled
> and the CPU must keep toggling the line at all times. Add a switch
> "always_running" to keep toggling the GPIO line regardless of the
> state of the soft part of the watchdog. The "armed" member keeps
> track of whether a timeout must also cause a reset.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Patch has been added to linux-watchdog-next.

Kind regards,
Wim.

