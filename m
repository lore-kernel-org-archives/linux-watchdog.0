Return-Path: <linux-watchdog-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:40876 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751250AbdJDA4M (ORCPT <rfc822;linux-watchdog@vger.kernel.org>);
        Tue, 3 Oct 2017 20:56:12 -0400
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [RFC v3 1/7] platform/x86: intel_pmc_ipc: Use devm_* calls in
 driver probe function
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
        "x86@kernel.org" <x86@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Ingo Molnar <mingo@redhat.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Zha Qipeng <qipeng.zha@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "dvhart@infradead.org" <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Shevchenko <andy@infradead.org>,
        Souvik Kumar Chakravarty <souvik.k.chakravarty@intel.com>,
        linux-rtc@vger.kernel.org, linux-watchdog@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Sathyanarayanan Kuppuswamy Natarajan <sathyaosid@gmail.com>
References: <cover.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <eada94e0dfe0302b22c16c22ba2ea806e096144a.1504588701.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <CAHp75VdXP+R=HrbicYSWTyLMZQWf54tmgviVW7J_+hhJBPkF1A@mail.gmail.com>
From: sathyanarayanan kuppuswamy
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <6c3580aa-1fc0-ea0a-0da3-782cb266429e@linux.intel.com>
Date: Tue, 3 Oct 2017 17:55:58 -0700
MIME-Version: 1.0
In-Reply-To: <CAHp75VdXP+R=HrbicYSWTyLMZQWf54tmgviVW7J_+hhJBPkF1A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-watchdog-owner@vger.kernel.org
List-Id: linux-watchdog@vger.kernel.org

Hi,


On 10/01/2017 07:34 AM, Andy Shevchenko wrote:
> On Tue, Sep 5, 2017 at 8:37 AM,
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
>> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
>> This patch cleans up unnecessary free/alloc calls in ipc_plat_probe(),
>> ipc_pci_probe() and ipc_plat_get_res() functions by using devm_*
>> calls.
>>
>> This patch also adds proper error handling for failure cases in
>> ipc_pci_probe() function.
>>
> Pushed (this patch only) to my review queue with slight style changes, thanks.
Thanks Andy. Will rebase my rest of the patches on top of this patch.
>
>> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>> ---
>>   drivers/platform/x86/intel_pmc_ipc.c | 104 ++++++++++++-----------------------
>>   1 file changed, 34 insertions(+), 70 deletions(-)
>>
>> Changes since v2:
>>   * Used pcim_* device managed functions.
>>
>> Changes since v1:
>>   * Merged devm_* related changes into a single function.
>>   * Instead of removing free_irq, use devm_free_irq function.
>>
>> diff --git a/drivers/platform/x86/intel_pmc_ipc.c b/drivers/platform/x86/intel_pmc_ipc.c
>> index bb792a5..5eef649 100644
>> --- a/drivers/platform/x86/intel_pmc_ipc.c
>> +++ b/drivers/platform/x86/intel_pmc_ipc.c
>> @@ -480,52 +480,39 @@ static irqreturn_t ioc(int irq, void *dev_id)
>>
>>   static int ipc_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>> -       resource_size_t pci_resource;
>>          int ret;
>> -       int len;
>> +       struct intel_pmc_ipc_dev *pmc = &ipcdev;
>>
>> -       ipcdev.dev = &pci_dev_get(pdev)->dev;
>> -       ipcdev.irq_mode = IPC_TRIGGER_MODE_IRQ;
>> +       /* Only one PMC is supported */
>> +       if (pmc->dev)
>> +               return -EBUSY;
>>
>> -       ret = pci_enable_device(pdev);
>> +       pmc->irq_mode = IPC_TRIGGER_MODE_IRQ;
>> +
>> +       ret = pcim_enable_device(pdev);
>>          if (ret)
>>                  return ret;
>>
>> -       ret = pci_request_regions(pdev, "intel_pmc_ipc");
>> +       ret = pcim_iomap_regions(pdev, 1 << 0, pci_name(pdev));
>>          if (ret)
>>                  return ret;
>>
>> -       pci_resource = pci_resource_start(pdev, 0);
>> -       len = pci_resource_len(pdev, 0);
>> -       if (!pci_resource || !len) {
>> -               dev_err(&pdev->dev, "Failed to get resource\n");
>> -               return -ENOMEM;
>> -       }
>> +       init_completion(&pmc->cmd_complete);
>>
>> -       init_completion(&ipcdev.cmd_complete);
>> +       pmc->ipc_base =  pcim_iomap_table(pdev)[0];
>>
>> -       if (request_irq(pdev->irq, ioc, 0, "intel_pmc_ipc", &ipcdev)) {
>> +       ret = devm_request_irq(&pdev->dev, pdev->irq, ioc, 0, "intel_pmc_ipc",
>> +                               pmc);
>> +       if (ret) {
>>                  dev_err(&pdev->dev, "Failed to request irq\n");
>> -               return -EBUSY;
>> +               return ret;
>>          }
>>
>> -       ipcdev.ipc_base = ioremap_nocache(pci_resource, len);
>> -       if (!ipcdev.ipc_base) {
>> -               dev_err(&pdev->dev, "Failed to ioremap ipc base\n");
>> -               free_irq(pdev->irq, &ipcdev);
>> -               ret = -ENOMEM;
>> -       }
>> +       pmc->dev = &pdev->dev;
>>
>> -       return ret;
>> -}
>> +       pci_set_drvdata(pdev, pmc);
>>
>> -static void ipc_pci_remove(struct pci_dev *pdev)
>> -{
>> -       free_irq(pdev->irq, &ipcdev);
>> -       pci_release_regions(pdev);
>> -       pci_dev_put(pdev);
>> -       iounmap(ipcdev.ipc_base);
>> -       ipcdev.dev = NULL;
>> +       return 0;
>>   }
>>
>>   static const struct pci_device_id ipc_pci_ids[] = {
>> @@ -540,7 +527,6 @@ static struct pci_driver ipc_pci_driver = {
>>          .name = "intel_pmc_ipc",
>>          .id_table = ipc_pci_ids,
>>          .probe = ipc_pci_probe,
>> -       .remove = ipc_pci_remove,
>>   };
>>
>>   static ssize_t intel_pmc_ipc_simple_cmd_store(struct device *dev,
>> @@ -849,18 +835,16 @@ static int ipc_plat_get_res(struct platform_device *pdev)
>>                  dev_err(&pdev->dev, "Failed to get ipc resource\n");
>>                  return -ENXIO;
>>          }
>> -       size = PLAT_RESOURCE_IPC_SIZE + PLAT_RESOURCE_GCR_SIZE;
>> +       res->end = (res->start + PLAT_RESOURCE_IPC_SIZE +
>> +                   PLAT_RESOURCE_GCR_SIZE - 1);
>>
>> -       if (!request_mem_region(res->start, size, pdev->name)) {
>> -               dev_err(&pdev->dev, "Failed to request ipc resource\n");
>> -               return -EBUSY;
>> -       }
>> -       addr = ioremap_nocache(res->start, size);
>> -       if (!addr) {
>> -               dev_err(&pdev->dev, "I/O memory remapping failed\n");
>> -               release_mem_region(res->start, size);
>> -               return -ENOMEM;
>> +       addr = devm_ioremap_resource(&pdev->dev, res);
>> +       if (IS_ERR(addr)) {
>> +               dev_err(&pdev->dev,
>> +                       "PMC I/O memory remapping failed\n");
>> +               return PTR_ERR(addr);
>>          }
>> +
>>          ipcdev.ipc_base = addr;
>>
>>          ipcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
>> @@ -917,7 +901,6 @@ MODULE_DEVICE_TABLE(acpi, ipc_acpi_ids);
>>
>>   static int ipc_plat_probe(struct platform_device *pdev)
>>   {
>> -       struct resource *res;
>>          int ret;
>>
>>          ipcdev.dev = &pdev->dev;
>> @@ -939,61 +922,42 @@ static int ipc_plat_probe(struct platform_device *pdev)
>>          ret = ipc_create_pmc_devices();
>>          if (ret) {
>>                  dev_err(&pdev->dev, "Failed to create pmc devices\n");
>> -               goto err_device;
>> +               return ret;
>>          }
>>
>> -       if (request_irq(ipcdev.irq, ioc, IRQF_NO_SUSPEND,
>> -                       "intel_pmc_ipc", &ipcdev)) {
>> +       if (devm_request_irq(&pdev->dev, ipcdev.irq, ioc, IRQF_NO_SUSPEND,
>> +                            "intel_pmc_ipc", &ipcdev)) {
>>                  dev_err(&pdev->dev, "Failed to request irq\n");
>>                  ret = -EBUSY;
>> -               goto err_irq;
>> +               goto unregister_devices;
>>          }
>>
>>          ret = sysfs_create_group(&pdev->dev.kobj, &intel_ipc_group);
>>          if (ret) {
>>                  dev_err(&pdev->dev, "Failed to create sysfs group %d\n",
>>                          ret);
>> -               goto err_sys;
>> +               goto unregister_devices;
>>          }
>>
>>          ipcdev.has_gcr_regs = true;
>>
>>          return 0;
>> -err_sys:
>> -       free_irq(ipcdev.irq, &ipcdev);
>> -err_irq:
>> +
>> +unregister_devices:
>>          platform_device_unregister(ipcdev.tco_dev);
>>          platform_device_unregister(ipcdev.punit_dev);
>>          platform_device_unregister(ipcdev.telemetry_dev);
>> -err_device:
>> -       iounmap(ipcdev.ipc_base);
>> -       res = platform_get_resource(pdev, IORESOURCE_MEM,
>> -                                   PLAT_RESOURCE_IPC_INDEX);
>> -       if (res) {
>> -               release_mem_region(res->start,
>> -                                  PLAT_RESOURCE_IPC_SIZE +
>> -                                  PLAT_RESOURCE_GCR_SIZE);
>> -       }
>> +
>>          return ret;
>>   }
>>
>>   static int ipc_plat_remove(struct platform_device *pdev)
>>   {
>> -       struct resource *res;
>> -
>>          sysfs_remove_group(&pdev->dev.kobj, &intel_ipc_group);
>> -       free_irq(ipcdev.irq, &ipcdev);
>> +       devm_free_irq(&pdev->dev, ipcdev.irq, &ipcdev);
>>          platform_device_unregister(ipcdev.tco_dev);
>>          platform_device_unregister(ipcdev.punit_dev);
>>          platform_device_unregister(ipcdev.telemetry_dev);
>> -       iounmap(ipcdev.ipc_base);
>> -       res = platform_get_resource(pdev, IORESOURCE_MEM,
>> -                                   PLAT_RESOURCE_IPC_INDEX);
>> -       if (res) {
>> -               release_mem_region(res->start,
>> -                                  PLAT_RESOURCE_IPC_SIZE +
>> -                                  PLAT_RESOURCE_GCR_SIZE);
>> -       }
>>          ipcdev.dev = NULL;
>>          return 0;
>>   }
>> --
>> 2.7.4
>>
>
>

-- 
Sathyanarayanan Kuppuswamy
Linux kernel developer

