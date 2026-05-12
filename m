Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61048383336;
	Tue, 12 May 2026 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604422; cv=none; b=r5HYBMJg+LUok+g8gKL+3k4KHBKgPdGnFluBCCkjMMLUFy6kenU1z8ay9EBdGG3yzxgBkiPBieMuRwKC/yFq+cJ6iuZWHwnGd/AbHMro4WO+xXJQdWhqRr4wrD2qiSJ7OcDwnRHa4Kphg22RsfpbZyQpJiJHYpWurjYdrZooomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604422; c=relaxed/simple;
	bh=IGhFG9xMSqnZDPwt60o3mQXipAuSnW6y1Td0TuFHv6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM8+H/IplO8uoHsbt7PAc4StnBT+dBfZbsznv1yFHwbFC/a+CrSM2Bis6DridyvLxPytqUeetKy0BpmR3m5gq/5vd8owN0nEkh3Xuv3mOHy9C1nVWZBEQZvbzHDNTbCxfJyxeFRuOYQio2cMHtFB+MZIyTbLKKM3aazK6ZtFSeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q8n9WGRQ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q8n9WGRQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778604422; x=1810140422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IGhFG9xMSqnZDPwt60o3mQXipAuSnW6y1Td0TuFHv6c=;
  b=Q8n9WGRQiGLiutUJDQCr2oYiC8hOLo8cbYJyuRER4gYDYoJOVbcM4x7B
   Wd8y+2OlZJDlK8I4YYqUYUNytwSFY4qgcJs9l800Vzs1b7aqzbt8dY3yw
   liZCKgTxQv5ujyf5T03SxxyDx+5TDCwCg327l+PEM7aJ+tuqRPVFoy8NQ
   r8fixvwKE03xXiYUOdAgATPuqLTFMPsRLOYiRDRgVzbMqfktVMtB9wubr
   CWqvDRpHA4+EEB5iek3NkEEoNhnF65kQNPEzH1H4f3YA/wACDqWWjTwSX
   2nAR/k33ild3tVK9TG4p83E7i/3Fi8MOgfBnczsBof3TChktRUsVIDiZ2
   A==;
X-CSE-ConnectionGUID: 30BRdBxYRvGgYCfjFa9mvw==
X-CSE-MsgGUID: kSxPB8TrSpm5X2KEwSwCnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90902353"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="90902353"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:47:01 -0700
X-CSE-ConnectionGUID: lhTH7dAvT66EDvtRohxRtQ==
X-CSE-MsgGUID: g9BoNHQlTSmmdSqn0o8V0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231409243"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 09:46:58 -0700
Date: Tue, 12 May 2026 19:46:56 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	linux-watchdog@vger.kernel.org,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] watchdog: ni903x_wdt: Check ACPI_COMPANION() against
 NULL
Message-ID: <agNZgKbjoxWjrMs3@ashevche-desk.local>
References: <2280455.irdbgypaU6@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2280455.irdbgypaU6@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 06:22:57PM +0200, Rafael J. Wysocki wrote:

> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> ni903x_wdt watchdog driver.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -	status = acpi_walk_resources(ACPI_HANDLE(dev), METHOD_NAME__CRS,
> +	status = acpi_walk_resources(handle, METHOD_NAME__CRS,
>  				     ni903x_resources, wdt);

This smells like we can move to regular acpi_dev_*() resource APIs rather than
custom walking via _CRS. But I haven't looked into the code.

-- 
With Best Regards,
Andy Shevchenko


