Return-Path: <joe@perches.com>
Return-path: <joe@perches.com>
Message-ID: <1509724953.15520.26.camel@perches.com>
Subject: Re: [PATCH] watchdog: pcwd_pci: mark expected switch fall-through
From: Joe Perches <joe@perches.com>
To: Guenter Roeck <linux@roeck-us.net>, Wim Van Sebroeck <wim@iguana.be>
Cc: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Fri, 03 Nov 2017 09:02:33 -0700
In-Reply-To: <20171103155426.GA21990@roeck-us.net>
References: <20171103144915.GA6243@embeddedor.com>
	 <20171103150423.GA10138@infomag.iguana.be>
	 <20171103155426.GA21990@roeck-us.net>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, 2017-11-03 at 08:54 -0700, Guenter Roeck wrote:
> On Fri, Nov 03, 2017 at 04:04:23PM +0100, Wim Van Sebroeck wrote:
> > Hi Gustavo,
> > 
> > > In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> > > where we are expecting to fall through.
> > > 
> > > Notice that in this particular case I replaced "Fall" with a proper
> > > "fall through" comment, which is what GCC is expecting to find.
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
> > > ---
> > >  drivers/watchdog/pcwd_pci.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/watchdog/pcwd_pci.c b/drivers/watchdog/pcwd_pci.c
> > > index c0d07ee..c882252 100644
> > > --- a/drivers/watchdog/pcwd_pci.c
> > > +++ b/drivers/watchdog/pcwd_pci.c
> > > @@ -545,7 +545,7 @@ static long pcipcwd_ioctl(struct file *file, unsigned int cmd,
> > >  			return -EINVAL;
> > >  
> > >  		pcipcwd_keepalive();
> > > -		/* Fall */
> > > +		/* fall through */
> > >  	}
> > >  
> > >  	case WDIOC_GETTIMEOUT:
> > > -- 
> > > 2.7.4
> > > 
> > 
> > Shouldn't the /* fall through */ come after the } ?
> > 
> 
> Good question. This is an unconditional code block needed to declare
> a local variable within the case statement. What is correct in that
> situation ?

I think it'd be clearer to avoid the trivial fallthrough
optimization/complexity and just directly use

		return put_user(new_heartbeat, p);

as heartbeat and new_heartbeat are now the same value here.
