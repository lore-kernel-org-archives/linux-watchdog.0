Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:37633 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938472AbdAIURP (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Mon, 9 Jan 2017 15:17:15 -0500
Date: Mon, 9 Jan 2017 12:17:13 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Wim Van Sebroeck <wim@iguana.be>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        linux-watchdog@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] watchdog: coh901327_wdt: Simplify error handling in
 probe function
Message-ID: <20170109201713.GB8668@roeck-us.net>
References: <1483500343-27113-1-git-send-email-linux@roeck-us.net>
 <CACRpkdbb9O=zRNox9RO9bNkAJ0grZ7vHy+8=9udJj0_Gw+k5hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbb9O=zRNox9RO9bNkAJ0grZ7vHy+8=9udJj0_Gw+k5hA@mail.gmail.com>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Mon, Jan 09, 2017 at 08:38:03PM +0100, Linus Walleij wrote:
> On Wed, Jan 4, 2017 at 4:25 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > Checking if there is no error followed by a goto if there is one is
> > confusing. Reverse the logic.
> >
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
Thanks!

Guenter
