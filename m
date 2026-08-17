Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2739D3C0;
	Mon, 17 Aug 2026 07:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952674; cv=none; b=ARrpXJIemLBh2uqgnM1jFR81FY9Ga4Clj+mPRPfPwvisLA9Zwum8dFIAzGkpRDvcv/AtUFXXYAkGMJqUG6lIkHy6qo3IyFEVHpACjah4mUVMpRhR5AmC5HJ9idchLe5xwXa7ppPHkh4MAMX7z77gJR+Iw2TLiwjSbH5igTE8Rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952674; c=relaxed/simple;
	bh=Dnb+XbrtyuqhjHyFkm447UwD9Y/MP2hNGk9Ct+Ds8Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyhq4aEFOfiorC4qdYALqZ1ggBGTlwejkdie84TMxttrBldMxFl3FVnoRkzMb5JV0U+hwHadfFhZgDUK47Tg199p7kBapc+HXWK9eQQFoq218fKG1Sg7w9bLeNC/Gx0kVjbdb8BIXjcPODqnYwGTaKjnspirw9X1lFWU2hSGDq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W00MuY2g; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W00MuY2g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786952673; x=1818488673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dnb+XbrtyuqhjHyFkm447UwD9Y/MP2hNGk9Ct+Ds8Po=;
  b=W00MuY2g53S2QTNsAlhNQGSH1KAdazhiVjykIIIC9/g11SltHIfsBGbN
   pJHvGPgoAN7vcgeYm86Ry8pxpGEy+WE50bBDSmv2oFGLJSLqCWZ0G3Y6y
   x3iddOb0tDoNKYs1khdBwa2pwHod9O6ueoUr0rd0JwUvy7Yxsk96/iNyo
   H90C0gy+NydRt6IGGd3HT0WOQ8JDD8yAiWHxUiLjjLF8TfEjO3MtD///3
   9jfN6lROeYf97iB8AvtBGSD9p9syxm5G6MLJk5a6hejHggk3wR5cUr2aj
   jSg1DOCiLNEPFOu4AHyGfDbsVZAsXsRQUNhMTWNAzhv4NcBQ5qoE3c5hG
   A==;
X-CSE-ConnectionGUID: 5fb3vfG2SN2XGERJCQrpmg==
X-CSE-MsgGUID: sm4q3516QNuq7mxRcZqj/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="86541854"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="86541854"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:44:32 -0700
X-CSE-ConnectionGUID: UNvMBamPScygexSOA1eEbg==
X-CSE-MsgGUID: VW2ePQYfQpSFQmcWfEPaJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="258628258"
Received: from igk-lkp-server01.igk.intel.com (HELO 3cba2a188a06) ([10.211.93.152])
  by fmviesa009.fm.intel.com with ESMTP; 17 Aug 2026 00:44:29 -0700
Received: from kbuild by 3cba2a188a06 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wvs1D-000000006lV-2hC4;
	Mon, 17 Aug 2026 07:44:27 +0000
Date: Mon, 17 Aug 2026 09:43:34 +0200
From: kernel test robot <lkp@intel.com>
To: Artem Lytkin <iprintercanon@gmail.com>, linux-watchdog@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	wim@linux-watchdog.org, linux@roeck-us.net, ojeda@kernel.org,
	miguel.ojeda.sandonis@gmail.com, dakr@kernel.org,
	aliceryhl@google.com, a.hindborg@kernel.org, lossin@kernel.org
Subject: Re: [PATCH v2 3/3] watchdog: softdog_rs: add Rust software watchdog
 driver
Message-ID: <202608170957.oeQwdAP3-lkp@intel.com>
References: <20260723161529.23759-4-iprintercanon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-watchdog@vger.kernel.org
List-Id: <linux-watchdog.vger.kernel.org>
List-Subscribe: <mailto:linux-watchdog+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-watchdog+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723161529.23759-4-iprintercanon@gmail.com>

Hi Artem,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rust/rust-next]
[also build test WARNING on linus/master v7.2 next-20260721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Artem-Lytkin/rust-watchdog-add-watchdog-device-abstraction/20260813-051424
base:   https://github.com/Rust-for-Linux/linux rust-next
patch link:    https://lore.kernel.org/r/20260723161529.23759-4-iprintercanon%40gmail.com
patch subject: [PATCH v2 3/3] watchdog: softdog_rs: add Rust software watchdog driver
config: x86_64-rhel-9.4-rust (https://download.01.org/0day-ci/archive/20260817/202608170957.oeQwdAP3-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
rustc: rustc 1.96.0 (ac68faa20 2026-05-25)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260817/202608170957.oeQwdAP3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202608170957.oeQwdAP3-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> warning: this `impl` can be derived
   --> rust/kernel/watchdog.rs:164:1
   |
   164 | / impl Default for Options {
   165 | |     fn default() -> Self {
   166 | |         Self {
   167 | |             timeout: 0,
   ...   |
   175 | | }
   | |_^
   |
   = help: for further information visit https://rust-lang.github.io/rust-clippy/rust-1.96.0/index.html#derivable_impls
   = note: `-W clippy::derivable-impls` implied by `-W clippy::all`
   = help: to override `-W clippy::all` add `#[allow(clippy::derivable_impls)]`
   help: replace the manual implementation with a derive attribute
   |
   147 + #[derive(Default)]
   148 | pub struct Options {
   |
--
>> warning: unresolved link to `super::Info::new`
   --> rust/kernel/watchdog.rs:98:7
   |
   98 | /// [`super::Info::new`].
   |       ^^^^^^^^^^^^^^^^ no item named `Info` in module `kernel`
   |
   = note: `#[warn(rustdoc::broken_intra_doc_links)]` on by default
--
>> warning: public documentation for `Registration` links to private item `Inner`
   --> rust/kernel/watchdog.rs:392:34
   |
   392 | /// - `inner` points at a live [`Inner`] obtained from [`KBox::into_raw`],
   |                                  ^^^^^ this item is private
   |
   = note: this link will resolve properly if you pass `--document-private-items`
   = note: `#[warn(rustdoc::private_intra_doc_links)]` on by default
--
>> warning: public documentation for `Registration` links to private item `Inner`
   --> rust/kernel/watchdog.rs:395:45
   |
   395 | ///   the `ops` and `data` fields of that [`Inner`].
   |                                             ^^^^^ this item is private
   |
   = note: this link will resolve properly if you pass `--document-private-items`

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
