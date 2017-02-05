Return-path: <shawnguo@kernel.org>
Date: Sun, 5 Feb 2017 11:45:06 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Baoyou Xie <baoyou.xie@linaro.org>
Cc: Guenter Roeck <linux@roeck-us.net>, Jun Nie <jun.nie@linaro.org>,
	wim@iguana.be, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
	linux-watchdog@vger.kernel.org,
	devicetree <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"xie.baoyou" <xie.baoyou@zte.com.cn>, chen.chaokai@zte.com.cn,
	wang.qiang01@zte.com.cn
Subject: Re: [PATCH v9 2/3] MAINTAINERS: add zx2967 watchdog controller
 driver to ARM ZTE architecture
Message-ID: <20170205034504.GD3407@dragon>
References: <1486172055-13162-1-git-send-email-baoyou.xie@linaro.org>
 <1486172055-13162-2-git-send-email-baoyou.xie@linaro.org>
 <4cba1be6-ee85-7371-ea02-1bf8e7eb628e@roeck-us.net>
 <CA+DQWkyOZPQORy-rVSqGY8Ht9xWttYt6Csp6pvShGG4OVA_2YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+DQWkyOZPQORy-rVSqGY8Ht9xWttYt6Csp6pvShGG4OVA_2YQ@mail.gmail.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Baoyou,

On Sun, Feb 05, 2017 at 10:36:38AM +0800, Baoyou Xie wrote:
> On 5 February 2017 at 08:05, Guenter Roeck <linux@roeck-us.net> wrote:
> 
> > On 02/03/2017 05:34 PM, Baoyou Xie wrote:
> >
> >> Add the zx2967 watchdog controller driver as maintained by ARM ZTE
> >> architecture maintainers, as they're parts of the core IP.
> >>
> >> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> >>
> >
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >
> > I assume you'll submit this patch through the arm tree ?
> >
> Could you please submit all three patches through your tree? Thanks a lot
> :)

Patch #2 is the only one that Guenter is concerned about, as there are
other subsystem related updates on the file.  I think Guenter's
suggestion is good, i.e. we have patch #1 and #3 go upstream through
watchdog tree, and later we update MAINTAINERS as needed via arm-soc
tree.

Shawn
