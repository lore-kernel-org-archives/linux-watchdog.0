Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0518037F010;
	Fri, 25 Sep 2026 11:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790335961; cv=none; b=ftofiX4f1wCh3RV8czFeUPVzHndNDXzfG6YRbsz49FsrHM8QwwYFsEn6PwyOvSzR9l3BVzioQV1YdN9V8kJSLHfzFjPL+il5XAemj46Or2irDrLXkau3bqOLAAcd8PPpwbBGN08pmOUbUEIPwOkMTTAdALjRzPwpFOOt8Tj5cPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790335961; c=relaxed/simple;
	bh=cI/1Nwr5hAKou1ae48YtU9XmaGW0dZVx/cUY/9gIqIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kU/9x6jgMVbUOZZGAM6KoXietL95q7YQmEdXw/WiDkYCc81RVAwcpBUcM2vH/KJ/QeSt/6za4CCI4FLeCVjSW44+KtGrvtVHknzJ2txAgg4rR8bnLEHzs9h7AUMt7sVAfUlGNLP4w8XlffLAoe3mysTV/kT/NyxgbOc+GwWBL48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7td/OLi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7td/OLi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BEE1F00899;
	Fri, 25 Sep 2026 11:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790335959;
	bh=7hGEN5Pw3qyGq1o8/Aw8crO7pIFvigQKaSany5lXKEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K7td/OLi9HNrH+3v52Wtzwe7VfnGioRCKEGdblQS4OqMr7PYJX8K7WJ9AQ3NYNX0l
	 HuvsuH+44lOpARJtiTohrYQYPMjANbSrqq0KASM6ufl5DR7CPkGm8DNOCogaU8nThY
	 DumpgT+70w4CJnCwFqfBnyziF//nDmrVHip4zb/zlgjQGP4JWPBr2P5GVwnuVWl+LT
	 GjSbxQmHXWneQS8XAPt2JDEzWWO3rx08EyvfPIsQ4j25UcYVzU+fSS9GCy1wKOFcEI
	 f3+S+UvDhkT2fsGtaAUQkCI3bVtjtpinBLLUqrfmgOzrfEaJHBEcB8rT14mraIib/b
	 qusSihdr/8tNg==
Date: Fri, 25 Sep 2026 13:32:32 +0200
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
Message-ID: <arZb0Cj3I7IvfmeK@red-moon>
References: <20260925-acpi-static-table-irq-probe-defer-v1-0-2c62125d0085@kernel.org>
 <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arZDwutoadki7tiZ@ashevche-desk.local>
 <arZNL9BnTGK0Klwc@red-moon>
 <arZS4vwxps01dGb7@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arZS4vwxps01dGb7@ashevche-desk.local>

On Fri, Sep 25, 2026 at 01:54:26PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 25, 2026 at 12:30:07PM +0200, Lorenzo Pieralisi wrote:
> > On Fri, Sep 25, 2026 at 12:49:54PM +0300, Andy Shevchenko wrote:
> > > On Fri, Sep 25, 2026 at 09:48:01AM +0200, Lorenzo Pieralisi wrote:
> 
> ...
> 
> > > > +static int acpi_static_fwnode_read_u32_prop_index(const struct fwnode_handle *fwnode,
> > > > +						  const char *propname,
> > > > +						  unsigned int index, u32 *value)
> > > > +{
> > > > +	u32 *values;
> > > > +	int ret, count;
> > > > +
> > > > +	count = fwnode_property_count_u32(fwnode, propname);
> > > > +	if (count < 0)
> > > > +		return count;
> > > > +
> > > > +	if (index >= count)
> > > > +		return -ENOENT;
> > > > +
> > > > +	values = kcalloc(count, sizeof(*values), GFP_KERNEL);
> > > > +	if (!values)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	ret = fwnode_property_read_u32_array(fwnode, propname, values, count);
> > > > +	if (!ret)
> > > > +		*value = values[index];
> > > 
> > > Use standard pattern, id est
> > > 
> > > 	if (ret)
> > > 		...
> > > 
> > > > +	kfree(values);
> > > 
> > > You want to use __free()
> > > 
> > > > +	return ret;
> > > > +}
> > > 
> > > I believe the whole approach is suboptimal, if you wish get indexed value (but why?)
> > 
> > Why what (that's what the irq_get() interface requires ?) I agree it is
> > suboptimal - the whole point of the series is an RFC on using properties
> > to store GSI number/flags, then how to read them we will optimize it
> > when/if we agree that's the approach to be taken.
> 
> Why to have indexed APIs. The callers usually do not want a single item from an
> array, they want all of them or a big pile (exception is the array of strings,
> but we have matching functions for that).
> 
> As per approach, this patch is against device property and I don't think we are
> going to agree on the approach taken in *this* patch.
> 
> > > it needs to be retrieved as that in the guts of ACPI. Allocating memory for the whole
> > > array to retrieve a single element is simply wrong.
> 
> ...
> 
> > > > +#define ACPI_IRQ_PROP_GSI		"linux,acpi-gsi"
> > > > +#define ACPI_IRQ_PROP_GSI_TRIGGER	"linux,acpi-gsi-trigger"
> > > > +#define ACPI_IRQ_PROP_GSI_POLARITY	"linux,acpi-gsi-polarity"
> > > 
> > > Oh... This sounds like a big ugly hack.
> > 
> > That does not help much I am afraid.
> > 
> > What's a ugly hack ? Property names ? Using properties for this purpose ?
> 
> Yes, properties started with "linux," for some core functionality.

I added a name for those out of thin air, again - the question is on
the approch, properties I can call them whatever we like.

I am not a fan of those myself, as mentioned in the cover letter.

> Yes, using properties for this also doesn't sound right. I think the problem
> here is in the table specifications or somewhere that deep. That's why we
> ended up in this series.
> 
> > Again, it is an RFC for this specific reason and I mentioned that in the
> > cover letter, thank you for your inputs.
> 
> And here we have a discussion started :-)

Thanks !

> P.S. Looks like I was too quick to jump into this thread. I will wait for
> others to share their view on all this.

No, thank you for chiming in so promptly. The main aim is to keep most
of the drivers and API unchanged for a bunch of devices created out of
static tables - ie minimize changes as much as possible, that's the
purpose.

Thanks,
Lorenzo
