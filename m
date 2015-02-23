Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:33587 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752135AbbBWT3W (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Mon, 23 Feb 2015 14:29:22 -0500
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1YPygz-003a9I-Js
	for linux-watchdog@vger.kernel.org; Mon, 23 Feb 2015 19:29:21 +0000
Date: Mon, 23 Feb 2015 11:29:14 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Wim Van Sebroeck <wim@iguana.be>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [21/27] watchdog: bcm281xx: Remove use of seq_printf return value
Message-ID: <20150223192914.GA26468@roeck-us.net>
References: <e370a587d7aa9f2bf7b409129a2283a10a134885.1424573328.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e370a587d7aa9f2bf7b409129a2283a10a134885.1424573328.git.joe@perches.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Sat, Feb 21, 2015 at 06:53:48PM -0800, Joe Perches wrote:
> The seq_printf return value, because it's frequently misused,
> will eventually be converted to void.
> 
> See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
>      seq_has_overflowed() and make public")
> 
> Signed-off-by: Joe Perches <joe@perches.com>

Acked-by: Guenter Roeck <linux~roeck-us.net>
