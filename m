Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CD1536A35C;
	Fri, 25 Sep 2026 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331395; cv=none; b=GXNOevl7iiXL9ufrqpSS0mlazRpKMTf20hKQIoLckQ4Pxmj7pAsTrf9RU7IV7g7qsQJcdw+X4igfH7DOZDWqIrngTQr4uaEYx59mqr9CxQTIKNzeWqGe2BFkrR4AMWRzpSOaTXqPcOMs2gGKk6TA6Rnf1Byb4YySGzM5OdnS+aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331395; c=relaxed/simple;
	bh=6sQjTl0h2YynQNsljBKq/SldxiED4mREqj3QZmkKDNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/20aHkUrlRK87D2WC5/btqZ280K9LxKitBnyYWEBtEDW9W7jwlLYVUTxg08tvf0Zh8NzAbfUKjrlRkOKv6ZrtBPSeNcVrKqoFbo6vGduz8BMRvQTQiQoHIf764nnMQjqG9n171UMJJufKDyK80E3EfXgO7pVlrfnvRdn7NfEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZSV2KrV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZSV2KrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2723F1F000FF;
	Fri, 25 Sep 2026 10:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331394;
	bh=Htdeexyfqui6yBn8pJU/UKqiEIPQ6aeL2MArnxM27yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WZSV2KrVGl3YQXdwQ0GOKP/uUWoB1odeW567eyoQ63pSoEH/KVP8CBuLOD4iLmkhj
	 vHko5XlwfS3mq1Jo5Il+ItolyLS0HPXeQvBXkt8yXolnC9jqWJlojS6fdCZV5ivxqs
	 3uo1KsaEN/fX7vUnVwrO0XmKQ4OwXwof9KzO2fC544tG63jk+3TYYEd6XeWYHTw+hE
	 MeINCKoErVD7xtiMarBSJl3jxUosmP6a/5cUQjCurirMhBEuWPtvEvpZDC/DozU4/6
	 S6B4gtTwIBS8AkyaNQEMvW/YVdXnk2eeO9ZF58oXdaKNc6Tgt4MzbrM3+8o4uBE6xw
	 jl/UPPQL/c55w==
Date: Fri, 25 Sep 2026 12:16:26 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Robin Murphy <robin.murphy@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	driver-core@lists.linux.dev, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RFC 03/11] driver core: platform: Add static ACPI nodes
 IRQ retrieval/mapping code
Message-ID: <arZJ-jqd1hXqVYgz@red-moon>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-3-2c62125d0085@kernel.org>
 <arZEx0113s0bbkXJ@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arZEx0113s0bbkXJ@ashevche-desk.local>

On Fri, Sep 25, 2026 at 12:54:15PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 25, 2026 at 09:48:02AM +0200, Lorenzo Pieralisi wrote:
> > ACPI static fwnodes types are not contemplated in the current
> > 
> > platform_get_irq_affinity()
> > 
> > implementation that is there to retrieve and map IRQs for a device.
> > 
> > Add fwnode_irq_get() to platform_get_irq_affinity() for static ACPI fwnodes
> > to overcome this shortcoming, enabling IRQ retrieval and mapping for the
> > ACPI static fwnode type.
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Danilo Krummrich <dakr@kernel.org>
> > ---
> 
> Same about the Cc list...
> 
> ...
> 
> > +	if (is_acpi_static_node(fwnode)) {
> > +		ret = fwnode_irq_get(fwnode, num);
> > +		if (ret > 0 || ret == -EPROBE_DEFER)
> > +			goto out;
> > +	}
> 
> This even doesn't sound right. If you know this is an ACPI-only feature what
> the fwnode has all to do with it? Call the respective ACPI-oriented function.

Yes, you are right, it is a last minute change since I noticed that just
calling fwnode_irq_get() without guards would catch previous failures so
it makes sense to do it on specific fwnode type (with is_acpi_static_node()
exported also for !CONFIG_ACPI).

Thanks,
Lorenzo
