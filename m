Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A093B7B76;
	Thu, 16 Jul 2026 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784201193; cv=none; b=tDG3pDHHQhU/ELOc+xOzULbvsNDlsvnXNz5D2JktWL09IoDLCcpiK9W8E4gk++c4rgq4Q8bk0tpOnkt5q2I75OIKb1pQJ4bCnk9LIEvDMPOkMkm+NAHZJ8MJQc+eljwTIyFZaDZV5JT/eutgcaqy3CWz5YgXGZdnJyexzjCGKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784201193; c=relaxed/simple;
	bh=gsehUhGZB4piSi9e6j8Qj10oHZ7/kBRiC1+NmhrqiyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m/cjV6HL4jtPerg16Bd6aaoHlhYtJfBUH5nrZ80G/idZvgXydmiMDBtykO1hldg/+eb7lvrwhd+92D8orqubfmpKNpmaWyISSVCkgaxTJhzZUxDk9ZK1JdkbCJ+rpi1P2d0YuSQridBhpH1Himx3jLaTYHZPZdItI1jLTid45eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZZazAIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZZazAIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECCCF1F000E9;
	Thu, 16 Jul 2026 11:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784201192;
	bh=yc6wXkbLTvWaqUxVj3VjWfyBF35rftwJBnNLuh/ixWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KZZazAIOjasuoeHcbFpneaGytz0cv4lcFU0wIOhIddGLHs9CRIxCFgkWz+YO3TobF
	 ikUvKSc2IUpuTWUf5/HJRWHwgV6pHwiuyOEje+CbcwgZG7KwG465DKoTyLajK6TG1u
	 mCLQubpNkby5hd8cGe75vY91LYbX2668UrUXB6msNcOjav4Ycg1vITdi+3NT1P02RW
	 jcZeTislKoJxPN1gRo9TrmDuxdmf56VfPVIVF3IeL1Mjz7c+/eTBlIvbrUWOLiLPp7
	 2bnkH7+LtnDt82bNaAZc4EK2S9mGBfwczVzUYjnJusMof6/284Nu7QTm3msVfuop8k
	 oYDFZgmApS9zA==
Date: Thu, 16 Jul 2026 12:26:28 +0100
From: Lee Jones <lee@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Ramiro Oliveira <ramiro.oliveira@advantech.com>,
	linux-hwmon@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-watchdog@vger.kernel.org, mfd@lists.linux.dev
Subject: Re: [PATCH v2 1/8] Add Advantech EIO driver
Message-ID: <20260716112628.GB1260374@google.com>
References: <20260714-upstream-v2-v2-0-76e5e41026db@advantech.com>
 <20260714-upstream-v2-v2-1-76e5e41026db@advantech.com>
 <20260714160814.3CA9B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714160814.3CA9B1F000E9@smtp.kernel.org>

On Tue, 14 Jul 2026, sashiko-bot@kernel.org wrote:

> Thank you for your contribution! Sashiko AI review found 15 potential issue(s) to consider:
> - [Critical] Driver uses zero-initialized `pmc[0]` array without verifying if the primary EC was successfully initialized, causing unintended I/O on system port 0x00.
> - [High] Missing success return for supported legacy code bases in `firmware_code_base()`.
> - [High] Incorrect validation of `devm_ioport_map()` return value.
> - [Medium] The `mfd_cell` array `eio_devs` is not declared as `const`.
> - [Medium] The driver uses `PLATFORM_DEVID_NONE` instead of `PLATFORM_DEVID_AUTO`, risking sysfs naming collisions.
> - [Medium] `acpi_ram_access()` truncates negative error codes into positive 8-bit integers.
> - [Medium] The requested region for the PNP base ports is off-by-one and fails to reserve the data port.
> - [Medium] Missing resource request for the dynamically discovered PMC command port.
> - [Medium] Unaligned memory access and endianness assumptions in `info_show()`.
> - [Medium] The IO port memory mapping is sized statically up to `0x49A`, but accesses dynamically discovered hardware registers which can exceed the mapped bounds.
> - [Medium] `pmc_clear` checks the wrong status bit (`IBF` instead of `OBF`) before attempting to clear pending garbage data.
> - [Medium] Hardware PNP configuration mode is left unlocked on error and skip paths in `eio_init()`.
> - [Low] The commit message prefix violates MFD subsystem naming conventions.
> - [Low] `MFD_EIO` uses the `isa_driver` API but lacks a Kconfig dependency on `ISA_BUS_API`.
> - [Low] Driver-specific header file is improperly placed in the global `include/linux/mfd/` directory.

That should keep you busy for a while.

Dropping this from my queue.

-- 
Lee Jones
