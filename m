Return-path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:11309 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752148AbcKOTXq (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 15 Nov 2016 14:23:46 -0500
Date: Wed, 16 Nov 2016 03:23:21 +0800
From: kbuild test robot <lkp@intel.com>
To: fu.wei@linaro.org
Cc: kbuild-all@01.org, rjw@rjwysocki.net, lenb@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, sudeep.holla@arm.com,
        hanjun.guo@linaro.org, linux-arm-kernel@lists.infradead.org,
        linaro-acpi@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, rruigrok@codeaurora.org,
        harba@codeaurora.org, cov@codeaurora.org, timur@codeaurora.org,
        graeme.gregory@linaro.org, al.stone@linaro.org, jcm@redhat.com,
        wei@redhat.com, arnd@arndb.de, catalin.marinas@arm.com,
        will.deacon@arm.com, Suravee.Suthikulpanit@amd.com,
        leo.duran@amd.com, wim@iguana.be, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, tn@semihalf.com,
        christoffer.dall@linaro.org, julien.grall@arm.com,
        Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v15 01/13] clocksource/drivers/arm_arch_timer: Move enums
 and defines to header file
Message-ID: <201611160359.fuY2etTU%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <1479215615-26950-2-git-send-email-fu.wei@linaro.org>
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Fu,

[auto build test ERROR on tip/timers/core]
[also build test ERROR on v4.9-rc5 next-20161115]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/fu-wei-linaro-org/acpi-clocksource-add-GTDT-driver-and-GTDT-support-in-arm_arch_timer/20161116-004444
config: arm-hisi_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

Note: the linux-review/fu-wei-linaro-org/acpi-clocksource-add-GTDT-driver-and-GTDT-support-in-arm_arch_timer/20161116-004444 HEAD 47004b0566d2fd65c05836078319b02c5af2a1fc builds fine.
      It only hurts bisectibility.

All error/warnings (new ones prefixed by >>):

>> drivers/clocksource/arm_arch_timer.c:70:13: error: variable 'arch_timer_uses_ppi' has initializer but incomplete type
    static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
                ^~~~~~
   drivers/clocksource/arm_arch_timer.c: In function '__arch_timer_setup':
>> drivers/clocksource/arm_arch_timer.c:358:3: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
      clk->irq = arch_timer_ppi[arch_timer_uses_ppi];
      ^~~
   drivers/clocksource/arm_arch_timer.c:359:3: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
      switch (arch_timer_uses_ppi) {
      ^~~~~~
   drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_has_nonsecure_ppi':
   drivers/clocksource/arm_arch_timer.c:447:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
     return (arch_timer_uses_ppi == PHYS_SECURE_PPI &&
     ^~~~~~
   drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_starting_cpu':
   drivers/clocksource/arm_arch_timer.c:471:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
     flags = check_ppi_trigger(arch_timer_ppi[arch_timer_uses_ppi]);
     ^~~~~
   drivers/clocksource/arm_arch_timer.c:472:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
     enable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], flags);
     ^~~~~~~~~~~~~~~~~
   drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_banner':
   drivers/clocksource/arm_arch_timer.c:512:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
     pr_info("Architected %s%s%s timer(s) running at %lu.%02luMHz (%s%s%s).\n",
     ^~~~~~~
   drivers/clocksource/arm_arch_timer.c: In function 'arch_counter_register':
   drivers/clocksource/arm_arch_timer.c:589:3: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
      if (IS_ENABLED(CONFIG_ARM64) || arch_timer_uses_ppi == VIRT_PPI)
      ^~
   drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_stop':
   drivers/clocksource/arm_arch_timer.c:624:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
     disable_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi]);
     ^~~~~~~~~~~~~~~~~~
   drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_register':
   drivers/clocksource/arm_arch_timer.c:687:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
     ppi = arch_timer_ppi[arch_timer_uses_ppi];
     ^~~
   drivers/clocksource/arm_arch_timer.c:688:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
     switch (arch_timer_uses_ppi) {
     ^~~~~~
   drivers/clocksource/arm_arch_timer.c:737:2: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
     free_percpu_irq(arch_timer_ppi[arch_timer_uses_ppi], arch_timer_evt);
     ^~~~~~~~~~~~~~~
   drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_init':
   drivers/clocksource/arm_arch_timer.c:838:4: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
       arch_timer_uses_ppi = HYP_PPI;
       ^~~~~~~~~~~~~~~~~~~
   drivers/clocksource/arm_arch_timer.c:841:4: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
       arch_timer_uses_ppi = PHYS_SECURE_PPI;
       ^~~~~~~~~~~~~~~~~~~
   drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_of_init':
   drivers/clocksource/arm_arch_timer.c:897:3: error: 'arch_timer_uses_ppi' has an incomplete type 'enum ppi_nr'
      arch_timer_uses_ppi = PHYS_SECURE_PPI;
      ^~~~~~~~~~~~~~~~~~~
   drivers/clocksource/arm_arch_timer.c: At top level:
>> drivers/clocksource/arm_arch_timer.c:70:20: error: storage size of 'arch_timer_uses_ppi' isn't known
    static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
                       ^~~~~~~~~~~~~~~~~~~
   drivers/clocksource/arm_arch_timer.c: In function 'arch_timer_has_nonsecure_ppi':
>> drivers/clocksource/arm_arch_timer.c:449:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^

vim +/arch_timer_uses_ppi +70 drivers/clocksource/arm_arch_timer.c

220069945 Stephen Boyd      2013-07-18  64  
8a4da6e36 Mark Rutland      2012-11-12  65  static u32 arch_timer_rate;
8a4da6e36 Mark Rutland      2012-11-12  66  static int arch_timer_ppi[MAX_TIMER_PPI];
8a4da6e36 Mark Rutland      2012-11-12  67  
8a4da6e36 Mark Rutland      2012-11-12  68  static struct clock_event_device __percpu *arch_timer_evt;
8a4da6e36 Mark Rutland      2012-11-12  69  
f81f03fa2 Marc Zyngier      2014-02-20 @70  static enum ppi_nr arch_timer_uses_ppi = VIRT_PPI;
82a561941 Lorenzo Pieralisi 2014-04-08  71  static bool arch_timer_c3stop;
220069945 Stephen Boyd      2013-07-18  72  static bool arch_timer_mem_use_virtual;
8a4da6e36 Mark Rutland      2012-11-12  73  

:::::: The code at line 70 was first introduced by commit
:::::: f81f03fa231a8c3aacd580759e73b9238b92ba29 arm64: Allow the arch timer to use the HYP timer

:::::: TO: Marc Zyngier <marc.zyngier@arm.com>
:::::: CC: Marc Zyngier <marc.zyngier@arm.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--opJtzjQTFsWo+cga
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
1kVQlah93YVpZ1vtwUq31Q2fMVsv7ewdnPIuqxPJ4V9m3zxg+KLz5tDXeET2rH9pYlqEwI+L
Eh3awU8wufYQ1PQYpmKQWOpOAOh2zwlIKQ1z2qGNkYBBrzeNzRNWuma6CCeNKj/9rG5vtI5V
oN6S9Ok2+uX77ePz5d/R0/c/nx4fnx5Hv5eo32DvfPj2/PZrtwCOjz9dVtig+wHGtlMWS+09
pUO0qYEhJIiDI2FPC1SSB0diAjKlHxIMM9BTWgpGcsZZXSsaVDDSGSbS8zsiyAESRRhLQjkJ
yXrD6Q1d8A/wg69wfgHmdxHj4F8fr2+KSexfMKpuDlMUeA5UINNpbecC7PVuT0gQ2Jp0k8rt
4f7+kgrCehBhkqXiEhzpXpNhcu6KO6rS6ec3aEbTMGNudhsFrC1hLaZnFpqXdWUVCwTX1QCk
s2lU22rW2rNEZlHfNGjaQrhWKczCUXz9wDFrlCeNW8BWtvoIs+/tSC60Gm6Q7KjHbCS73nqR
XipRkfRmrZIQcjUiEU890kgA6KmeFkT3ASM1nXb7GxbfFB9lifWHEKdTewQAS+KFYjkmhDpA
FKgCQlN7i7RFRs/qcXbZfek0vZ4F2fvt8/ZweymnQ2/w4R91kiBZRsFyWhB8SxbbO2Yv+nXJ
MmF19GsxEcC0v1AR9fp5ezdPHk2V2ejh5fbwtzU7mV0mC8/T8Yv7W5t+U9H6DypYNumdwnhc
uT4+qkhdsCWqgj/+z/BLFSZc5nWg+Oz5taNW2+Bi8w0Bv4O/moTKvrQhGJIj7hJlSdYOL2mo
wmCZ3xUVRNVd222XCtqGFs8HIYFPUlfghq4b/m4piiiANrptWUMqP7mGhTLWt52mvlTa6520
st219snT99v7v6Pv17c34A7Ugrfsz+rL1bzQKiH2K4+svpaxdIluyIllLWf4KtXKS5pVtbIS
GpCTO5SixzAnibjUmp5xryAkE/08EY2X9hv6qn85cTuv6I69RNHvg6Or+vd9XgHZPNXmp3/e
YDnZhsn1jFQCElef4NsGIZA2ACISlO40ztYLgksqAVtvsXIARDFZEAKvosss5FOPiC2iEWLe
CQelZ/vWd3TfXgJ72p1R9cY+0O2wOiaEkGP0q2MyxXw28wg7Sd1toUjbhkd13W7vPzMzYp5N
Z2Ls9bJAzo3+9mSvtPZuyI5Wz4qKhjbbbUvrJlkZx9+lCaGs0gEKSfjHMXDkVtAF4Z+SWbW7
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
0kQhAQA=

--opJtzjQTFsWo+cga--
