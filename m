Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:44508 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbcJEWfo (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Wed, 5 Oct 2016 18:35:44 -0400
Date: Wed, 5 Oct 2016 23:35:38 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH] watchdog: ath79_wdt: fix build failure
Message-ID: <20161005223538.GH19539@ZenIV.linux.org.uk>
References: <1475645318-15254-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475645318-15254-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Wed, Oct 05, 2016 at 10:58:38AM +0530, Sudip Mukherjee wrote:
> The build of mips ath79_defconfig was failing with the error:
> drivers/watchdog/ath79_wdt.c:164:5:
> 	error: implicit declaration of function 'get_user'
> drivers/watchdog/ath79_wdt.c:196:3:
> 	error: implicit declaration of function 'copy_to_user'
> drivers/watchdog/ath79_wdt.c:201:3:
> 	error: implicit declaration of function 'put_user'
> 
> Quoting Al Viro - "another victim of indirect include chains"
> 
> Fixes: 58a8f3b69e07 ("mips: separate extable.h, switch module.h to it")
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

That was actually fixed in today's -next...
