Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33971 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbbAPFBv (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Fri, 16 Jan 2015 00:01:51 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YBz2c-001uEo-MQ
	for linux-watchdog@vger.kernel.org; Fri, 16 Jan 2015 05:01:51 +0000
Message-ID: <54B89B35.2010209@roeck-us.net>
Date: Thu, 15 Jan 2015 21:01:41 -0800
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Mike Looijmans <mike.looijmans@topic.nl>
CC: wim@iguana.be, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] gpio_wdt: Add "always_running" feature to GPIO watchdog
References: <20150113215212.GA12804@roeck-us.net> <1421216909-3109-1-git-send-email-mike.looijmans@topic.nl>
In-Reply-To: <1421216909-3109-1-git-send-email-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On 01/13/2015 10:28 PM, Mike Looijmans wrote:
> On some chips, like the TPS386000, the trigger cannot be disabled
> and the CPU must keep toggling the line at all times. Add a switch
> "always_running" to keep toggling the GPIO line regardless of the
> state of the soft part of the watchdog. The "armed" member keeps
> track of whether a timeout must also cause a reset.
>
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

