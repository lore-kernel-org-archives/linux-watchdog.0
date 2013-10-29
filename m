Return-Path: <wimvs@spo001.leaseweb.com>
Date: Tue, 29 Oct 2013 08:48:00 +0100
From: Wim Van Sebroeck <wim@iguana.be>
To: Barry Song <21cnbao@gmail.com>
Cc: linux@roeck-us.net, linux-watchdog@vger.kernel.org,
	workgroup.linux@csr.com, Xianglong Du <Xianglong.Du@csr.com>,
	Barry Song <Baohua.Song@csr.com>,
	Romain Izard <romain.izard.pro@gmail.com>
Subject: Re: [PATCH v7] watchdog: sirf: add watchdog driver of CSR SiRFprimaII and SiRFatlasVI
Message-ID: <20131029074800.GD19704@spo001.leaseweb.com>
References: <1380672829-13440-1-git-send-email-Baohua.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1380672829-13440-1-git-send-email-Baohua.Song@csr.com>
Sender: <wimvs@spo001.leaseweb.com>
List-ID: <linux-watchdog@vger.kernel.org>

Hi Barry and Xianglong,

> From: Xianglong Du <Xianglong.Du@csr.com>
> 
> On CSR SiRFprimaII and SiRFatlasVI, the 6th timer can act as a watchdog
> timer when the Watchdog mode is enabled.
> 
> watchdog occur when TIMER watchdog counter matches the value software
> pre-set, when this event occurs, the effect is the same as the system
> software reset.
> 
> Signed-off-by: Xianglong Du <Xianglong.Du@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> Cc: Romain Izard <romain.izard.pro@gmail.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

This patch has been added to linux-watchdog-next.

Kind regards,
Wim.
