Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B3C2D3EF2;
	Tue, 29 Sep 2026 08:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790671269; cv=none; b=fxps5qJ26Y/9H+a3H5lBa0GgIRteFrlIp8H2C6pMKSJmRAZrVW25hiLXzelEHarLBWGiGcf6KddzrWHaAPoQ28lQTNwC5qgH4nakstchxnwfvX1pK++Cq51EJla4hA0IoW6PK8UmGa6LTHOpu2ccFz++6Tysa1OlxJ5DTh52/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790671269; c=relaxed/simple;
	bh=RXL3VKCB8JmZhe72jnR/7nxayEB0x35O9P+qAzxLhn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OY63yUgatEsSEN9LdM/miJ/W3n3tZLcOC47ZlJVk8TuNXRENWuTOeaO/8wbPReu/D9UDqzF8zeagwpoI50ld4heMuYyhEFWK6GnNrvfNmruKmvCLOuQ8iRJ4Gx7cwrcn2KEEXD7+yD7DefTf7ro7xvuheltjrEP6OzASa0xPn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VCGBkWTv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VCGBkWTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6341F1F000FF;
	Tue, 29 Sep 2026 08:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790671267;
	bh=Wwlrc4OA5be2l/cOfc4ELm7R1PPcfoHaHpyuiOxuo3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VCGBkWTvGAAys65g5LYILlIf9iKCwcLFlV12HZy7R3l3OCLy1pRSBhaJqK+tCxWRz
	 BUnQFxvHg6mQzXfdE+oz29U01ZlFC8iLJjcGONGJkaisQMhx91Xij1XTfiiuadGmyq
	 GbbpAtRx3iDnN8Ww78FVy+tCsZrLdgLPuSBOi5yX3sNAU3D3Tmz/fsQ2pa2nSFfJZm
	 pOy1YV1sMgN2pMi+a4tIMsr0qTuzYGSnUZT5KVKpvZuumLNLb8BtXQNjDfHO2T2o7A
	 zggDnaI5j2j4H+pHzoWRWhQQxUY8Z2+LdINYb3duFXB/fMYG0Aqjhf21xu/+2S6i1b
	 g8QJ2utxwgAig==
Date: Tue, 29 Sep 2026 10:40:59 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Ashok Raj <ashok.raj@oss.qualcomm.com>
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
	Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev,
	linux-watchdog@vger.kernel.org
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
Message-ID: <art5m5QPXAOAvkvW@red-moon>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arr3IhF0bwN4uzUP@hu-ashoraj-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arr3IhF0bwN4uzUP@hu-ashoraj-lv.qualcomm.com>

On Mon, Sep 28, 2026 at 04:24:18PM -0700, Ashok Raj wrote:
> 
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
> > 
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: Bartosz Golaszewski <brgl@kernel.org>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > ---
> >  drivers/acpi/property.c | 69 ++++++++++++++++++++++++++++++++++++++++++++++++-
> >  include/linux/acpi.h    |  4 +++
> >  2 files changed, 72 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > index 8ee5a1f0eb48..c609100c08db 100644
> > --- a/drivers/acpi/property.c
> > +++ b/drivers/acpi/property.c
> > @@ -1766,7 +1766,74 @@ static int acpi_fwnode_irq_get(const struct fwnode_handle *fwnode,
> >  
> >  DECLARE_ACPI_FWNODE_OPS(acpi_device_fwnode_ops);
> >  DECLARE_ACPI_FWNODE_OPS(acpi_data_fwnode_ops);
> > -const struct fwnode_operations acpi_static_fwnode_ops;
> > +
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
> > +
> 
> You lookup with a propname, and then qualify with and index? is it
> possible to have the different index but same propname? 

What is the question :) ? It is to retrieve a property value at a specific
index.

> Alternately you can send the list to caller and they can use the ones
> they need?
> 
> 
> > +	kfree(values);
> > +	return ret;
> > +}
> > +
> > +static int acpi_static_fwnode_read_string_array(const struct fwnode_handle *fwnode,
> > +						const char *propname,
> > +						const char **val, size_t nval)
> > +{
> > +	/* Route string handling to secondary software nodes */
> > +	return -EINVAL;
> > +}
> > +
> > +static int acpi_static_fwnode_irq_get(const struct fwnode_handle *fwnode,
> > +				      unsigned int index)
> > +{
> > +	u32 gsi, trigger, polarity;
> > +	int ret;
> > +
> > +	if (!fwnode->secondary)
> > +		return -ENODEV;
> > +
> > +	fwnode = fwnode->secondary;
> > +
> > +	ret = acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GSI,
> > +						index, &gsi);
> > +	if (ret)
> > +		return ret == -ENOENT ? -ENXIO : ret;
> > +
> > +	ret = acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GSI_TRIGGER,
> > +						index, &trigger);
> > +	if (ret)
> > +		return ret == -ENOENT ? -ENXIO : ret;
> > +
> > +	ret = acpi_static_fwnode_read_u32_prop_index(fwnode, ACPI_IRQ_PROP_GSI_POLARITY,
> > +						index, &polarity);
> > +	if (ret)
> > +		return ret == -ENOENT ? -ENXIO : ret;
> 
> Consolidate return to one place? 

Yes it can (and trigger and polarity can be just one property "flags", FWIW),
if we agree that's what will do, which I doubt.

Thanks,
Lorenzo
