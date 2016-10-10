Return-path: <robherring2@gmail.com>
Date: Mon, 10 Oct 2016 15:32:12 -0500
From: Rob Herring <robh@kernel.org>
To: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
Cc: Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>,
	Frank Rowand <frowand.list@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Wim Van Sebroeck <wim@iguana.be>, Jean Delvare <jdelvare@suse.com>,
	Georgi Vlaev <gvlaev@juniper.net>,
	Guenter Roeck <linux@roeck-us.net>,
	JawaharBalaji Thirumalaisamy <jawaharb@juniper.net>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, linux-watchdog@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH 0/7] Introduce PTX1K Boot FPGA driver
Message-ID: <20161010203212.GA10128@rob-hp-laptop>
References: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1475853724-22557-1-git-send-email-pantelis.antoniou@konsulko.com>
List-ID: <linux-watchdog@vger.kernel.org>

On Fri, Oct 07, 2016 at 06:21:57PM +0300, Pantelis Antoniou wrote:
> Add Juniper's PTX1K Boot FPGA driver. Those FPGAs
> are present in Juniper's PTX series of routers.
> 
> The MFD driver provices watchdog/mtd/hwmon devices.
> 
> There are full device tree binding documents for the
> master mfd driver and for the slave driver.
> 
> This patchset is against mainline as of today: v4.8-9431-g3477d16
> and is dependent on the "Juniper prerequisites" and
> "Juniper infrastructure" patchsets sent earlier.

You've exceeded the number of patches I'm willing to review at once for 
one person and I'm tired of making the same comments. So fix anything 
I've already mentioned elsewhere and send this series again.

Rob
