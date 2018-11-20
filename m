Return-Path: <tiny.windzz@gmail.com>
Return-path: <tiny.windzz@gmail.com>
MIME-Version: 1.0
References: <20181120132359.19799-1-tiny.windzz@gmail.com> <8abef7ab-1d77-cf88-748c-11e54c760f34@roeck-us.net>
In-Reply-To: <8abef7ab-1d77-cf88-748c-11e54c760f34@roeck-us.net>
From: Frank Lee <tiny.windzz@gmail.com>
Date: Tue, 20 Nov 2018 22:44:30 +0800
Message-ID: <CAEExFWv-iarJbgXEN78P5BjvzRqnHoLgnjnV9YZU4hKPcT4e9g@mail.gmail.com>
Subject: Re: [PATCH] watchdog: cpwd: add of_node_put()
To: Guenter Roeck <linux@roeck-us.net>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-watchdog@vger.kernel.org>

On Tue, Nov 20, 2018 at 10:34 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 11/20/18 5:23 AM, Yangtao Li wrote:
> > use of_node_put() to release the refcount.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >   drivers/watchdog/cpwd.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/watchdog/cpwd.c b/drivers/watchdog/cpwd.c
> > index aee0b25cf10d..d3a81642ada5 100644
> > --- a/drivers/watchdog/cpwd.c
> > +++ b/drivers/watchdog/cpwd.c
> > @@ -617,6 +617,7 @@ static int cpwd_probe(struct platform_device *op)
> >
> >       platform_set_drvdata(op, p);
> >       cpwd_device =3D p;
> > +     of_node_put(options);
>
> It would be better to do that right after its last use to also cover
> error handling.
>
> Guenter
>
> >       return 0;
> >
> >   out_unregister:
> >
>
Hi Guenter=EF=BC=9A

Yes, you're right. I will send the second version right away.

Yours,
    Yangtao
