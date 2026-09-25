Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C76493D4E;
	Fri, 25 Sep 2026 10:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790332216; cv=none; b=HIPH4vB2T0skZSUFbyGn/0ilQ6ahYBLTOHeRfgTX2t7WtLnt6HvDm4Hv/IohO9h7DvXjN37r1Q5sm5534yOfbEpDk4HqknswrmyiepcBDW8rXkqpKeV7hL3a8fqDVDPz4FlrY3EiQAFVHNm9zJiUbxreVsrkntTkPtZT/UuXtbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790332216; c=relaxed/simple;
	bh=G38+9Xi1BL5x3HemPTXAYafBVSe9mK5t4PCHwW9U/+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4C4POeeCdRem7tpP15VRVyBMMboNjxjtOc6j0SEXsx9paNeP+gxcSqoaagLgdRA6hcnRojfTBgFJN0hdelDeQ4tTzcZ0BbvUSIggA/dKk43/wghbtSbYO/+vC1o+BUKV0Yfa/I3LINdWdIbrv17rOmYqxu6yOEmyWiT+Oyjlz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/PC1qgX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/PC1qgX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDABB1F00893;
	Fri, 25 Sep 2026 10:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790332214;
	bh=u0UNCp5jO3JC5Gl7IqvtlCZ2BmcuD3WupLp9PnEdBrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I/PC1qgXUGnaE4DvqOgsMbPQTZn2nVuMsNNnif3JLU7v5NloNltpDdIV8iSK/TZmb
	 +mh2Ck91xOwSKHSDdKxXVz+yyj9whQWuVYYfiwRqhDyH+faUYY18Z5YIrBpkrNRMP/
	 uNQQSf5eQE0TVTsS8LXy/Nosl63JqRWVc6SrqVl6KnrUsRYWFCbxqae0EI3G+ypZ2H
	 ZQCIEgAXl7BfPtcdBhc7/IQz4+BQz+gu6/Hd/EeX6nhIQcmXdxpAvbN6U8LddkyeKn
	 x7NaFqcK4ooeA/eUN0TRkoaionFpY5Uf7ceIDpt8lo2PUceZQJUiFPLkrU1u6m6nc5
	 mUqEOB9Hh9sPQ==
Date: Fri, 25 Sep 2026 12:30:07 +0200
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
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
Message-ID: <arZNL9BnTGK0Klwc@red-moon>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arZDwutoadki7tiZ@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arZDwutoadki7tiZ@ashevche-desk.local>

On Fri, Sep 25, 2026 at 12:49:54PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi wrote:
> > To describe and map GSIs for firmware nodes created out of ACPI static
> > table entries in a uniform way it is required to define some standard
> > properties and attach them to ACPI static fwnode as secondary nodes.
> > 
> > Define properties names to describe GSIs and their trigger-mode/polarity,
> > and implement an irq_get() callback for static fwnodes so that core code
> > can retrieve and map IRQs for ACPI static fwnodes in standard manner.
> > 
> > An empty stub for property_read_string_array() is also added, so that
> > the fwnode_irq_get_byname() interface falls back (through
> > fwnode_property_read_string_array()) to the secondary
> > fwnode to grab the "interrupt-names" property.
> 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Bartosz Golaszewski <brgl@kernel.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > ---
> 
> Same here, please avoid polluting commit message with the Cc list.
> 
> ...
> 
> > +static int acpi_static_fwnode_read_u32_prop_index(const struct fwnode_handle *fwnode,
> > +						  const char *propname,
> > +						  unsigned int index, u32 *value)
> > +{
> > +	u32 *values;
> > +	int ret, count;
> > +
> > +	count = fwnode_property_count_u32(fwnode, propname);
> > +	if (count < 0)
> > +		return count;
> > +
> > +	if (index >= count)
> > +		return -ENOENT;
> > +
> > +	values = kcalloc(count, sizeof(*values), GFP_KERNEL);
> > +	if (!values)
> > +		return -ENOMEM;
> > +
> > +	ret = fwnode_property_read_u32_array(fwnode, propname, values, count);
> > +	if (!ret)
> > +		*value = values[index];
> 
> Use standard pattern, id est
> 
> 	if (ret)
> 		...
> 
> > +	kfree(values);
> 
> You want to use __free()
> 
> > +	return ret;
> > +}
> 
> I believe the whole approach is suboptimal, if you wish get indexed value (but why?)

Why what (that's what the irq_get() interface requires ?) I agree it is
suboptimal - the whole point of the series is an RFC on using properties
to store GSI number/flags, then how to read them we will optimize it
when/if we agree that's the approach to be taken.

> it needs to be retrieved as that in the guts of ACPI. Allocating memory for the whole
> array to retrieve a single element is simply wrong.
> 
> ...
> 
> > +#define ACPI_IRQ_PROP_GSI		"linux,acpi-gsi"
> > +#define ACPI_IRQ_PROP_GSI_TRIGGER	"linux,acpi-gsi-trigger"
> > +#define ACPI_IRQ_PROP_GSI_POLARITY	"linux,acpi-gsi-polarity"
> 
> Oh... This sounds like a big ugly hack.

That does not help much I am afraid.

What's a ugly hack ? Property names ? Using properties for this purpose ?

Again, it is an RFC for this specific reason and I mentioned that in the
cover letter, thank you for your inputs.

Lorenzo
