Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from eddie.linux-mips.org ([78.24.191.182]:53929 "EHLO
	cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751957Ab1CBPPD (ORCPT
	<rfc822;linux-watchdog@vger.kernel.org>);
	Wed, 2 Mar 2011 10:15:03 -0500
Received: from localhost.localdomain ([127.0.0.1]:42573 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491180Ab1CBPA3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 2 Mar 2011 16:00:29 +0100
Date: Wed, 2 Mar 2011 15:29:33 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: John Crispin <blogic@openwrt.org>,
	Ralph Hempel <ralph.hempel@lantiq.com>,
	Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
Message-ID: <20110302142933.GA18221@linux-mips.org>
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org>
 <1298996006-15960-6-git-send-email-blogic@openwrt.org>
 <4D6E286D.9050100@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D6E286D.9050100@mvista.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Mar 02, 2011 at 02:22:21PM +0300, Sergei Shtylyov wrote:

> >+	switch (cmd) {
> >+	case WDIOC_GETSUPPORT:
> >+		ret = copy_to_user((struct watchdog_info __user *)arg, &ident,
> >+				sizeof(ident)) ? -EFAULT : 0;
> 
>    Doesn't copy_to_user() return 0 or -EFAULT?

No and that's a common cause of bugs.  copy_{from,to}_user returns the
number of characters that could be be copied so the conversion to an
error code is needed here.

The function takes a void argument and there is no benefit from casting
to the full struct watchdog_info __user * pointer type other than maybe
clarity to the human reader.

While nitpicking - there should be one space between include and < in
#include <blah.h>.

  Ralf
