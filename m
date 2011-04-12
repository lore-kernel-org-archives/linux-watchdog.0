Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:54286 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750720Ab1DLLmC (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 12 Apr 2011 07:42:02 -0400
Date: Tue, 12 Apr 2011 12:41:55 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nat Gurumoorthy <natg@google.com>
Cc: Jean Delvare <khali@linux-fr.org>,
	Guenter Roeck <guenter.roeck@ericsson.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Mike Waychison <mikew@google.com>, lm-sensors@lm-sensors.org,
	linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v4 1/2] Use "request_muxed_region" in it87 watchdog
 drivers
Message-ID: <20110412124155.36787390@lxorguk.ukuu.org.uk>
In-Reply-To: <1302565974-23906-1-git-send-email-natg@google.com>
References: <1302565858-23849-1-git-send-email-natg@google.com>
	<1302565974-23906-1-git-send-email-natg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

> +	while (!request_muxed_region(REG, 2, NAME))
> +		continue;
> +

This shouldn't need the loop ? - is it only working with the loop
present ?


Otherwise this looks good - I'd just like to understand if the loop was
needed (indicating a bug has crept into the muxed alloc code somewhere
perhaps) or not

Alan
