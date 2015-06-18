Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33179 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756276AbbFRQjl (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Thu, 18 Jun 2015 12:39:41 -0400
Date: Thu, 18 Jun 2015 09:39:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: poeschel@lemonage.de
Cc: wim@iguana.be, corbet@lwn.net, linux-doc@vger.kernel.org,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: watchdog: docs: omap_wdt also understands nowayout
Message-ID: <20150618163938.GA21683@roeck-us.net>
References: <1434532407-6989-1-git-send-email-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1434532407-6989-1-git-send-email-poeschel@lemonage.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Jun 17, 2015 at 11:13:27AM +0200, poeschel@lemonage.de wrote:
> From: Lars Poeschel <poeschel@lemonage.de>
> 
> The omap_wdt kernel driver also understands the nowayout module
> parameter. This updates the watchdog-parameters.txt to reflect this fact.
> 
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
