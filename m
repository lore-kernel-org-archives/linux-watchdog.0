Return-path: <alexandre.belloni@free-electrons.com>
Date: Thu, 2 Mar 2017 18:35:41 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Wim Van Sebroeck <wim@iguana.be>,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-watchdog@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] watchdog: sama5d4: Fix setting timeout when
 watchdog is disabled
Message-ID: <20170302173541.ggkypwjbhmtftbvi@piout.net>
References: <20170216193053.5546-1-alexandre.belloni@free-electrons.com>
 <20170216193053.5546-2-alexandre.belloni@free-electrons.com>
 <968ef53e-c3c4-5322-020a-8382ce367931@roeck-us.net>
 <20170217151625.hv2vn5imx2kyeftt@piout.net>
 <c9f336fd-8761-7999-4ac0-cf68eb6c8ba1@roeck-us.net>
 <20170219235213.qcxfne5yvs3uzwg3@piout.net>
 <cc75a19f-0d99-4d26-0789-6cd750983990@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc75a19f-0d99-4d26-0789-6cd750983990@roeck-us.net>
List-ID: <linux-watchdog@vger.kernel.org>

Hi,

On 19/02/2017 at 20:46:13 -0800, Guenter Roeck wrote:
> Please keep us in the loop.
> 

I've sent a new series that solves the issues we were seeing. I've tied
to document as much as possible and to make the driver as simple as
possible.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
