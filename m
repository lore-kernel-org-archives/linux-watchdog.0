Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:44168 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbbKQRbp (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Tue, 17 Nov 2015 12:31:45 -0500
Date: Tue, 17 Nov 2015 09:31:42 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>,
	kernel@savoirfairelinux.com
Subject: Re: [PATCH v2 02/13] watchdog: bcm47xx_wdt: use core restart handler
Message-ID: <20151117173142.GB11035@roeck-us.net>
References: <1447694891-24831-1-git-send-email-damien.riegel@savoirfairelinux.com>
 <1447694891-24831-3-git-send-email-damien.riegel@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1447694891-24831-3-git-send-email-damien.riegel@savoirfairelinux.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Nov 16, 2015 at 12:28:00PM -0500, Damien Riegel wrote:
> Get rid of the custom restart handler by using the one provided by the
> watchdog core.
> 
> Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
