Return-Path: <linux-watchdog-owner@vger.kernel.org>
Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45488 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbdKCPy3 (ORCPT
        <rfc822;linux-watchdog@vger.kernel.org>);
        Fri, 3 Nov 2017 11:54:29 -0400
Date: Fri, 3 Nov 2017 08:54:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Wim Van Sebroeck <wim@iguana.be>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: pcwd_pci: mark expected switch fall-through
Message-ID: <20171103155426.GA21990@roeck-us.net>
References: <20171103144915.GA6243@embeddedor.com>
 <20171103150423.GA10138@infomag.iguana.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171103150423.GA10138@infomag.iguana.be>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

On Fri, Nov 03, 2017 at 04:04:23PM +0100, Wim Van Sebroeck wrote:
> Hi Gustavo,
> 
> > In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > where we are expecting to fall through.
> > 
> > Notice that in this particular case I replaced "Fall" with a proper
> > "fall through" comment, which is what GCC is expecting to find.
> > 
> > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> > ---
> >  drivers/watchdog/pcwd_pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
> > index c0d07ee..c882252 100644
> > --- a/drivers/watchdog/pcwd_pci.c
> > +++ b/drivers/watchdog/pcwd_pci.c
> > @@ -545,7 +545,7 @@ static long pcipcwd_ioctl(struct file *file, unsigned int cmd,
> >  			return -EINVAL;
> >  
> >  		pcipcwd_keepalive();
> > -		/* Fall */
> > +		/* fall through */
> >  	}
> >  
> >  	case WDIOC_GETTIMEOUT:
> > -- 
> > 2.7.4
> > 
> 
> Shouldn't the /* fall through */ come after the } ?
> 
Good question. This is an unconditional code block needed to declare
a local variable within the case statement. What is correct in that
situation ?

Guenter
