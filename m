Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44666 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbbAMMLu (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 13 Jan 2015 07:11:50 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YB0K6-001bes-6d
	for linux-watchdog@vger.kernel.org; Tue, 13 Jan 2015 12:11:50 +0000
Date: Tue, 13 Jan 2015 04:11:40 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-kernel@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org
Subject: Re: [22/28] watchdog: drop owner assignment from platform_drivers
Message-ID: <20150113121140.GA26815@roeck-us.net>
References: <1419196495-9626-23-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1419196495-9626-23-git-send-email-wsa@the-dreams.de>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sun, Dec 21, 2014 at 10:14:43PM +0100, Wolfram Sang wrote:
> This platform_driver does not need to set an owner, it will be populated by the
> driver core.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
