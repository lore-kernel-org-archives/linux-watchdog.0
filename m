Return-path: <ukl@pengutronix.de>
Date: Sun, 26 Apr 2015 21:12:16 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Guenter Roeck <linux@roeck-us.net>
Cc: balbi@ti.com, Lokesh Vutla <lokeshvutla@ti.com>,
	Wim Van Sebroeck <wim@iguana.be>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	linux-watchdog@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 1a/3] watchdog: omap: clearify device tree documentation
Message-ID: <20150426191216.GZ19431@pengutronix.de>
References: <20150424190207.GU19431@pengutronix.de>
 <1429906850-5420-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150425021024.GA14963@saruman.tx.rr.com>
 <553D0450.6050403@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <553D0450.6050403@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

On Sun, Apr 26, 2015 at 08:29:20AM -0700, Guenter Roeck wrote:
> On 04/24/2015 07:10 PM, Felipe Balbi wrote:
> >On Fri, Apr 24, 2015 at 10:20:50PM +0200, Uwe Kleine-König wrote:
> >>ti,hwmods doesn't belong into the compatible section but is a property
> >>on it's own. Also reformat the section of required properties to match the
> >>usual style of dt binding documents.
> >>
> >>Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> >
> >looks great to me, thanks
> >
> >Reviewed-by: Felipe Balbi <balbi@ti.com>
> >Acked-by: Felipe Balbi <balbi@ti.com>
> >
> 
> Reviewed-by: and Acked-by: are mutually exclusive.
Really? Acked means you like it and Reviewed by means you looked deeper
into it. Maybe reviewing without liking isn't likely, *shrug*.

The command

	$ git rev-list linus/master | while read cmmt; do git cat-file commit $cmmt | awk -v cmmt=$cmmt '$1 ~ /(Acked|Reviewed)-by:/ { $1 = ""; print cmmt " " $0 }' | sort; done | uniq -d

should catch all commits that have duplicate tags. There are a few,
*shrugagain*.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
